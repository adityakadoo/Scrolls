---
title: "Fifa 23"
date: 2023-12-06T15:12:03+05:30
draft: false
math: true
tags: []
description: "testing svg rendering"
resources:
- name: thumbnail
  src: 
toc: false
footer: true
---

<div class="svg-box">
    <div id="football">
    </div>
</div>

<script>
var football = (home = {
    shape: "1-3-1",
    def_shape: "3-2-0",
    pre_shape: "3-1-1",
    pos_shape: "1-4-2",
    atk_shape: "1-2-2",
    def_map: [
      [[0,1]],
      [[0,0],[1,0],[0,2]],
      [[1,1]]
    ],
    pre_map: [
      [[0,1]],
      [[0,0],[1,0],[0,2]],
      [[2,0]]
    ],
    pos_map: [
      [[0,0]],
      [[1,0],[2,0],[1,3]],
      [[2,1]]
    ],
    atk_map: [
      [[0,0]],
      [[1,0],[2,0],[1,1]],
      [[2,1]]
    ],
    spread: 70,
    depth: 27.5
  }, away = {
    shape: "2-2-1",
    def_shape: "4-1",
    pre_shape: "2-3",
    pos_shape: "1-3-1",
    atk_shape: "1-1-3",
    def_map: [
      [[0,1],[0,2]],
      [[0,0],[0,3]],
      [[1,0]]
    ],
    pre_map: [
      [[0,0],[0,1]],
      [[1,0],[1,2]],
      [[1,1]]
    ],
    pos_map: [
      [[1,1],[0,0]],
      [[1,0],[1,2]],
      [[2,0]]
    ],
    atk_map: [
      [[1,0],[0,0]],
      [[2,0],[2,2]],
      [[2,1]]
    ],
    spread: 70,
    depth: 27.5
  }, ball_x=57.5, sliders = {
    ball_pos: [false, false],
    home_depth: [false, false],
    away_depth: [false, false],
    home_spread: [false, false],
    away_spread: [false, false]
  }) => {
  let my_id = "football";
  let field_w = 115, field_h = 74, field_pad = 15, slider_pad = 7.5, cir_r = 10, spot_r = 0.4, goal_w = 3, goal_h = 8, pen_spot = 12, outer_box_h = 44, outer_box_w = 18, inner_box_h = 20, inner_box_w = 6, corner = 1, max_atk = 36, min_def = 0, button_dim = 3.5, dot_offset = 0.4, text_box = 15;
  let transform_shape = formation => formation.split("-").map(e => Number(e));
  let play_w = field_w - home.depth - away.depth;

  let get_pos_from_shape = (shape_str, width, spread) => {
    let shape = transform_shape(shape_str);
    let res = [];
    let x_pos = 0;
    for(let l=0;l<shape.length;l++){
      let f = l===shape.length-1 && shape[l]>2 ? -1 : 1;
      let y_pos = spread*(1-shape[l]) / (2*shape[l]+f) + field_h/2;
      let temp = [];
      for(let i=0;i<shape[l];i++){
        temp.push([x_pos, y_pos]);
        y_pos += 2*spread / (2*shape[l]+f);
      }
      res.push(temp);
      x_pos += width / (shape.length-1);
    }
    return res;
  };

  let get_pos_from_ball = (ball_pos, h, a_line) => {
    let res = [];
    let shape = transform_shape(h.shape);
    for (let i=0;i<shape.length;i++){
      let temp = [];
      for (let j=0;j<shape[i];j++)
        temp.push([0,0]);
      res.push(temp);
    }
    res.push([[0,0]]);

    let def_pos = get_pos_from_shape(h.def_shape, max_atk-min_def, h.spread*outer_box_h/field_h);
    def_pos = def_pos.map(l => l.map(e => [e[0]+min_def-dot_offset,e[1]]));
    def_pos.push([[0,field_h/2]]);
    let pre_pos = get_pos_from_shape(h.pre_shape, play_w, h.spread);
    pre_pos = pre_pos.map(l => l.map(e => [e[0]+h.depth-dot_offset,e[1]]));
    pre_pos.push([[inner_box_w,field_h/2]]);
    let pos = get_pos_from_shape(h.shape, play_w, h.spread);
    pos = pos.map(l => l.map(e => [e[0]+h.depth-dot_offset,e[1]]));
    pos.push([[(inner_box_w+pen_spot)/2,field_h/2]]);
    let pos_pos = get_pos_from_shape(h.pos_shape, play_w, h.spread);
    pos_pos = pos_pos.map(l => l.map(e => [e[0]+h.depth-dot_offset,e[1]]));
    pos_pos.push([[pen_spot,field_h/2]]);
    let atk_pos = get_pos_from_shape(h.atk_shape, max_atk-min_def, h.spread*outer_box_h/field_h);
    atk_pos = atk_pos.map(l => l.map(e => [e[0]+field_w-max_atk-2*dot_offset,e[1]]));
    atk_pos.push([[outer_box_w,field_h/2]]);

    let t = 1;
    if (ball_pos < h.depth)
      t = ball_pos / h.depth / 4;
    else if (ball_pos < field_w/2)
      t = 0.25 + (ball_pos - h.depth) / (field_w/2 - h.depth) / 4;
    else if (ball_pos < field_w - a_line)
      t = 0.5 + (ball_pos - field_w/2) / (field_w/2 - a_line) / 4;
    else if (ball_pos < field_w)
      t =  0.75 + (ball_pos - field_w + a_line) / a_line / 4;
    t = 1-t;
    let f = [
      t*t*t*t,
      4*t*t*t*(1-t),
      6*t*t*(1-t)*(1-t),
      4*t*(1-t)*(1-t)*(1-t),
      (1-t)*(1-t)*(1-t)*(1-t),
    ];
    for (let i=0;i<shape.length;i++)
      for (let j=0;j<shape[i];j++){
        let def_m = h.def_map[i][j], pre_m = h.pre_map[i][j], pos_m = h.pos_map[i][j], atk_m = h.atk_map[i][j];
        res[i][j][0] += def_pos[def_m[0]][def_m[1]][0]*f[0];
        res[i][j][1] += def_pos[def_m[0]][def_m[1]][1]*f[0];
        res[i][j][0] += pre_pos[pre_m[0]][pre_m[1]][0]*f[1];
        res[i][j][1] += pre_pos[pre_m[0]][pre_m[1]][1]*f[1];
        res[i][j][0] += pos[i][j][0]*f[2];
        res[i][j][1] += pos[i][j][1]*f[2];
        res[i][j][0] += pos_pos[pos_m[0]][pos_m[1]][0]*f[3];
        res[i][j][1] += pos_pos[pos_m[0]][pos_m[1]][1]*f[3];
        res[i][j][0] += atk_pos[atk_m[0]][atk_m[1]][0]*f[4];
        res[i][j][1] += atk_pos[atk_m[0]][atk_m[1]][1]*f[4];
      }
    res[res.length-1][0][0] += def_pos[def_pos.length-1][0][0]*f[0];
    res[res.length-1][0][1] += def_pos[def_pos.length-1][0][1]*f[0];
    res[res.length-1][0][0] += pre_pos[pre_pos.length-1][0][0]*f[1];
    res[res.length-1][0][1] += pre_pos[pre_pos.length-1][0][1]*f[1];
    res[res.length-1][0][0] += pos[pos.length-1][0][0]*f[2];
    res[res.length-1][0][1] += pos[pos.length-1][0][1]*f[2];
    res[res.length-1][0][0] += pos_pos[pos_pos.length-1][0][0]*f[3];
    res[res.length-1][0][1] += pos_pos[pos_pos.length-1][0][1]*f[3];
    res[res.length-1][0][0] += atk_pos[atk_pos.length-1][0][0]*f[4];
    res[res.length-1][0][1] += atk_pos[atk_pos.length-1][0][1]*f[4];


    return res.reduce(
      (acc, val) => acc.concat(val),
      [],
    );
  };

  home.pos = get_pos_from_ball(ball_x, home, away.depth);
  away.pos = get_pos_from_ball(field_w-ball_x, away, home.depth);
  away.pos = away.pos.map(e => [field_w-e[0], field_h-e[1]]);

  let dot_r = 1;
  let player_dots = (pos_list, is_home=true) => {
    return pos_list.map(e=>
      `<circle cx="${e[0]+field_pad}" cy="${e[1]+field_pad}" r="${dot_r}" fill="${is_home?`var(--sp-color)`:`black`}"></circle>`
    ).join(``);
  }
  let voronoi_edges = (edge_list) => {
    return edge_list.map(e=>
      `<line x1="${e[0][0]+field_pad}" y1="${e[0][1]+field_pad}" x2="${e[1][0]+field_pad}" y2="${e[1][1]+field_pad}" style="stroke-width:0.1;stroke:black;"></line>`
    ).join(``);
  }
  let voronoi_cells = (cell_list, is_home=true) => {
    return cell_list.map(cell=>
      `<path d="M ${field_pad+cell[0][0]},${field_pad+cell[0][1]} L ${cell.reverse().map(e=>`${field_pad+e[0]},${field_pad+e[1]}`).join(` `)}" fill="${is_home?`var(--hl-color)`:`#00000050`}" style="stroke-width:0;"></path>`
    ).join(``);
  }

  let voronoi = new Voronoi();
  let bbox = {xl: -0.175, xr: field_w+0.175, yt: -0.175, yb: field_h+0.175};
  let sites = home.pos.concat(away.pos).map(e => {
    return {x: e[0], y: e[1]}
  });
  let diagram = voronoi.compute(sites, bbox);
  let diagram_edges = diagram.edges.map(edge=>[[edge.va.x,edge.va.y], [edge.vb.x,edge.vb.y]]);
  let home_cells = diagram.cells.filter(cell=>{
    let p = [cell.site.x, cell.site.y];
    return home.pos.map(q=> p[0]===q[0] && p[1]===q[1]).some(Boolean);
  }).map(cell=>{
    let res = [];
    cell.halfedges.forEach(h=>{
      let new_point = h.getEndpoint();
      res.push([new_point.x, new_point.y]);
    });
    return res;
  });
  let away_cells = diagram.cells.filter(cell=>{
    let p = [cell.site.x, cell.site.y];
    return away.pos.map(q=> p[0]===q[0] && p[1]===q[1]).some(Boolean);
  }).map(cell=>{
    let res = [];
    cell.halfedges.forEach(h=>{
      let new_point = h.getEndpoint();
      res.push([new_point.x, new_point.y]);
    });
    return res;
  });

  let upper_box = (text_box-slider_pad+button_dim)*2/3, lower_box = (text_box-slider_pad+button_dim)*1/3, box_w = (field_w+field_pad+button_dim)/2;
  
  document.getElementById(my_id).innerHTML = `
    <svg xmlns="http://www.w3.org/2000/svg" width="100%" viewBox="0 0 ${field_w+2*field_pad} ${field_h+2*field_pad+text_box}">
    
    <line x1="${field_pad}" x2="${field_pad+field_w}" y1="${slider_pad}" y2="${slider_pad}"></line>
    <line x1="${field_pad}" x2="${field_pad}" y1="${slider_pad-button_dim}" y2="${slider_pad+button_dim}"></line>
    <line x1="${field_pad+field_w}" x2="${field_pad+field_w}" y1="${slider_pad-button_dim}" y2="${slider_pad+button_dim}"></line>
    <circle cx="${field_pad+ball_x}" cy="${slider_pad}" r="${dot_r}" fill="gray"></circle>
    <path id="${my_id}-ball_dec" d="M ${field_pad-button_dim/2},${slider_pad} L ${field_pad-button_dim/2},${slider_pad+button_dim} ${field_pad-3*button_dim/2},${slider_pad} ${field_pad-button_dim/2},${slider_pad-button_dim} ${field_pad-button_dim/2},${slider_pad}" fill="${sliders.ball_pos[0] ? `var(--sp-color)` : `transparent`}" style="cursor:pointer;"></path>
    <path id="${my_id}-ball_inc" d="M ${field_pad+field_w+button_dim/2},${slider_pad} L ${field_pad+field_w+button_dim/2},${slider_pad+button_dim} ${field_pad+field_w+3*button_dim/2},${slider_pad} ${field_pad+field_w+button_dim/2},${slider_pad-button_dim} ${field_pad+field_w+button_dim/2},${slider_pad}" fill="${sliders.ball_pos[1] ? `var(--sp-color)` : `transparent`}" style="cursor:pointer;"></path>

    <line y1="${field_pad}" y2="${field_pad+field_h}" x1="${slider_pad}" x2="${slider_pad}"></line>
    <line y1="${field_pad}" y2="${field_pad}" x1="${slider_pad-button_dim}" x2="${slider_pad+button_dim}"></line>
    <line y1="${field_pad+field_h}" y2="${field_pad+field_h}" x1="${slider_pad-button_dim}" x2="${slider_pad+button_dim}"></line>
    <rect y="${field_pad+(field_h-home.spread)/2}" x="${slider_pad-button_dim/2}" width="${button_dim}" height="${home.spread}" fill="gray"></rect>
    <path id="${my_id}-home_spread_inc" d="M ${slider_pad},${field_pad-button_dim/2} L ${slider_pad+button_dim},${field_pad-button_dim/2} ${slider_pad},${field_pad-3*button_dim/2} ${slider_pad-button_dim},${field_pad-button_dim/2} ${slider_pad},${field_pad-button_dim/2}" fill="${sliders.home_spread[1] ? `var(--sp-color)` : `transparent`}" style="cursor:pointer;"></path>
    <path id="${my_id}-home_spread_dec" d="M ${slider_pad},${field_pad+field_h+button_dim/2} L ${slider_pad+button_dim},${field_pad+field_h+button_dim/2} ${slider_pad},${field_pad+field_h+3*button_dim/2} ${slider_pad-button_dim},${field_pad+field_h+button_dim/2} ${slider_pad},${field_pad+field_h+button_dim/2}" fill="${sliders.home_spread[0] ? `var(--sp-color)` : `transparent`}" style="cursor:pointer;"></path>

    <line y1="${field_pad}" y2="${field_pad+field_h}" x1="${slider_pad+field_w+field_pad}" x2="${slider_pad+field_w+field_pad}"></line>
    <line y1="${field_pad}" y2="${field_pad}" x1="${slider_pad-button_dim+field_w+field_pad}" x2="${slider_pad+button_dim+field_w+field_pad}"></line>
    <line y1="${field_pad+field_h}" y2="${field_pad+field_h}" x1="${slider_pad-button_dim+field_w+field_pad}" x2="${slider_pad+button_dim+field_w+field_pad}"></line>
    <rect y="${field_pad+(field_h-away.spread)/2}" x="${slider_pad-button_dim/2+field_w+field_pad}" width="${button_dim}" height="${away.spread}" fill="gray"></rect>
    <path id="${my_id}-away_spread_inc" d="M ${slider_pad+field_w+field_pad},${field_pad-button_dim/2} L ${slider_pad+button_dim+field_w+field_pad},${field_pad-button_dim/2} ${slider_pad+field_w+field_pad},${field_pad-3*button_dim/2} ${slider_pad-button_dim+field_w+field_pad},${field_pad-button_dim/2} ${slider_pad+field_w+field_pad},${field_pad-button_dim/2}" fill="${sliders.away_spread[1] ? `var(--sp-color)` : `transparent`}" style="cursor:pointer;"></path>
    <path id="${my_id}-away_spread_dec" d="M ${slider_pad+field_w+field_pad},${field_pad+field_h+button_dim/2} L ${slider_pad+button_dim+field_w+field_pad},${field_pad+field_h+button_dim/2} ${slider_pad+field_w+field_pad},${field_pad+field_h+3*button_dim/2} ${slider_pad-button_dim+field_w+field_pad},${field_pad+field_h+button_dim/2} ${slider_pad+field_w+field_pad},${field_pad+field_h+button_dim/2}" fill="${sliders.away_spread[0] ? `var(--sp-color)` : `transparent`}" style="cursor:pointer;"></path>

    <line x1="${field_pad}" x2="${field_pad+field_w/2-2*button_dim}" y1="${field_h+field_pad+slider_pad}" y2="${field_h+field_pad+slider_pad}"></line>
    <line x1="${field_pad}" x2="${field_pad}" y1="${field_h+field_pad+slider_pad-button_dim}" y2="${field_h+field_pad+slider_pad+button_dim}"></line>
    <line x1="${field_pad+field_w/2-2*button_dim+0.1}" x2="${field_pad+field_w/2-2*button_dim+0.1}" y1="${field_h+field_pad+slider_pad-button_dim}" y2="${field_h+field_pad+slider_pad+button_dim}"></line>
    <rect x="${field_pad+home.depth}" y="${field_h+field_pad+slider_pad-button_dim/2}" width="${field_w/2-2*button_dim-home.depth+0.1}" height="${button_dim}" fill="gray"></rect>
    <path id="${my_id}-home_depth_dec" d="M ${field_pad-button_dim/2},${field_h+field_pad+slider_pad} L ${field_pad-button_dim/2},${field_h+field_pad+slider_pad+button_dim} ${field_pad-3*button_dim/2},${field_h+field_pad+slider_pad} ${field_pad-button_dim/2},${field_h+field_pad+slider_pad-button_dim} ${field_pad-button_dim/2},${field_h+field_pad+slider_pad}" fill="${sliders.home_depth[0] ? `var(--sp-color)` : `transparent`}" style="cursor:pointer;"></path>
    <path id="${my_id}-home_depth_inc" d="M ${field_pad+field_w/2-3*button_dim/2},${field_h+field_pad+slider_pad} L ${field_pad+field_w/2-3*button_dim/2},${field_h+field_pad+slider_pad+button_dim} ${field_pad+field_w/2-button_dim/2},${field_h+field_pad+slider_pad} ${field_pad+field_w/2-3*button_dim/2},${field_h+field_pad+slider_pad-button_dim} ${field_pad+field_w/2-3*button_dim/2},${field_h+field_pad+slider_pad}" fill="${sliders.home_depth[1] ? `var(--sp-color)` : `transparent`}" style="cursor:pointer;"></path>

    <line x1="${field_pad+field_w/2+2*button_dim}" x2="${field_pad+field_w}" y1="${field_h+field_pad+slider_pad}" y2="${field_h+field_pad+slider_pad}"></line>
    <line x1="${field_pad+field_w/2+2*button_dim-0.1}" x2="${field_pad+field_w/2+2*button_dim-0.1}" y1="${field_h+field_pad+slider_pad-button_dim}" y2="${field_h+field_pad+slider_pad+button_dim}"></line>
    <line x1="${field_pad+field_w}" x2="${field_pad+field_w}" y1="${field_h+field_pad+slider_pad-button_dim}" y2="${field_h+field_pad+slider_pad+button_dim}"></line>
    <rect x="${field_pad+field_w/2+2*button_dim-0.1}" y="${field_h+field_pad+slider_pad-button_dim/2}" width="${field_w/2-2*button_dim-away.depth+0.1}" height="${button_dim}" fill="gray"></rect>
    <path id="${my_id}-away_depth_dec" d="M ${field_pad-button_dim/2+field_w/2+2*button_dim},${field_h+field_pad+slider_pad} L ${field_pad-button_dim/2+field_w/2+2*button_dim},${field_h+field_pad+slider_pad+button_dim} ${field_pad-3*button_dim/2+field_w/2+2*button_dim},${field_h+field_pad+slider_pad} ${field_pad-button_dim/2+field_w/2+2*button_dim},${field_h+field_pad+slider_pad-button_dim} ${field_pad-button_dim/2+field_w/2+2*button_dim},${field_h+field_pad+slider_pad}" fill="${sliders.away_depth[0] ? `var(--sp-color)` : `transparent`}" style="cursor:pointer;"></path>
    <path id="${my_id}-away_depth_inc" d="M ${field_pad+field_w/2-3*button_dim/2+field_w/2+2*button_dim},${field_h+field_pad+slider_pad} L ${field_pad+field_w/2-3*button_dim/2+field_w/2+2*button_dim},${field_h+field_pad+slider_pad+button_dim} ${field_pad+field_w/2+field_w/2+3*button_dim/2},${field_h+field_pad+slider_pad} ${field_pad+field_w/2-3*button_dim/2+field_w/2+2*button_dim},${field_h+field_pad+slider_pad-button_dim} ${field_pad+field_w/2-3*button_dim/2+field_w/2+2*button_dim},${field_h+field_pad+slider_pad}" fill="${sliders.away_depth[1] ? `var(--sp-color)` : `transparent`}" style="cursor:pointer;"></path>

    <rect x="${field_pad}" y="${field_pad}" height="${field_h}" width="${field_w}" fill="gray" stroke="transparent"></rect>
    <line x1="${field_pad+field_w/2}" y1="${field_pad}" x2="${field_pad+field_w/2}" y2="${field_pad+field_h}"></line>
    <circle cx="${field_pad+field_w/2}" cy="${field_pad+field_h/2}" r="${cir_r}" fill="transparent"></circle>
    <circle cx="${field_pad+field_w/2}" cy="${field_pad+field_h/2}" r="${spot_r}" fill="white"></circle>
    <rect x="${field_pad-goal_w}" y="${field_pad+field_h/2-goal_h/2}" height="${goal_h}" width="${goal_w}" fill="var(--hl-color)"></rect>
    <circle cx="${pen_spot+field_pad}" cy="${field_pad+field_h/2}" r="${cir_r}" fill="transparent"></circle>
    <rect x="${field_pad}" y="${field_pad+field_h/2-outer_box_h/2}" height="${outer_box_h}" width="${outer_box_w}" fill="gray"></rect>
    <circle cx="${pen_spot+field_pad}" cy="${field_pad+field_h/2}" r="${spot_r}" fill="white"></circle>
    <rect x="${field_pad}" y="${field_pad+field_h/2-inner_box_h/2}" height="${inner_box_h}" width="${inner_box_w}" fill="gray"></rect>
    <rect x="${field_w+field_pad}" y="${field_pad+field_h/2-goal_h/2}" height="${goal_h}" width="${goal_w}" fill="transparent"></rect>
    <circle cx="${field_w-pen_spot+field_pad}" cy="${field_pad+field_h/2}" r="${cir_r}" fill="transparent"></circle>
    <rect x="${field_w+field_pad-outer_box_w}" y="${field_pad+field_h/2-outer_box_h/2}" height="${outer_box_h}" width="${outer_box_w}" fill="gray"></rect>
    <circle cx="${field_w-pen_spot+field_pad}" cy="${field_pad+field_h/2}" r="${spot_r}" fill="white"></circle>
    <rect x="${field_w+field_pad-inner_box_w}" y="${field_pad+field_h/2-inner_box_h/2}" height="${inner_box_h}" width="${inner_box_w}" fill="gray"></rect>
    <path d="M ${field_pad} ${field_pad+corner} Q ${field_pad+corner} ${field_pad+corner} ${field_pad+corner} ${field_pad}" fill="transparent"></path>
    <path d="M ${field_pad+field_w} ${field_pad+corner} Q ${field_pad+field_w-corner} ${field_pad+corner} ${field_pad+field_w-corner} ${field_pad}" fill="transparent"></path>
    <path d="M ${field_pad+field_w} ${field_pad+field_h-corner} Q ${field_pad+field_w-corner} ${field_pad+field_h-corner} ${field_pad+field_w-corner} ${field_pad+field_h}" fill="transparent"></path>
    <path d="M ${field_pad} ${field_pad+field_h-corner} Q ${field_pad+corner} ${field_pad+field_h-corner} ${field_pad+corner} ${field_pad+field_h}" fill="transparent"></path>`+voronoi_cells(home_cells)+player_dots(home.pos)+player_dots(away.pos, false)+voronoi_edges(diagram_edges)+`

    <text x="${slider_pad-button_dim/2}" y="${field_pad*2+field_h+upper_box*2/3}" font-size="${2*upper_box/3}" fill="white">MAIN : ${home.shape}</text>
    <rect x="${slider_pad-button_dim}" y="${field_pad*2+field_h}" height="${upper_box}" width="${field_w/2+field_pad/2+button_dim/2}" fill="transparent"></rect>
    <text x="${slider_pad-button_dim/2}" y="${field_pad*2+field_h+upper_box+2*lower_box/3}" font-size="${2*lower_box/3}" fill="white">ULTRA-DEF</text>
    <text x="${slider_pad-button_dim/2+box_w/4}" y="${field_pad*2+field_h+upper_box+2*lower_box/3}" font-size="${2*lower_box/3}" fill="white">DEFENCE</text>
    <text x="${slider_pad-button_dim/2+2*box_w/4}" y="${field_pad*2+field_h+upper_box+2*lower_box/3}" font-size="${2*lower_box/3}" fill="white">ATTACK</text>
    <text x="${slider_pad-button_dim/2+3*box_w/4}" y="${field_pad*2+field_h+upper_box+2*lower_box/3}" font-size="${2*lower_box/3}" fill="white">ULTRA-ATK</text>
    <rect x="${slider_pad-button_dim}" y="${field_pad*2+field_h+upper_box}" height="${lower_box}" width="${box_w/4}" fill="transparent"></rect>
    <rect x="${slider_pad-button_dim+box_w/4}" y="${field_pad*2+field_h+upper_box}" height="${lower_box}" width="${box_w/4}" fill="transparent"></rect>
    <rect x="${slider_pad-button_dim+2*box_w/4}" y="${field_pad*2+field_h+upper_box}" height="${lower_box}" width="${box_w/4}" fill="transparent"></rect>
    <rect x="${slider_pad-button_dim+3*box_w/4}" y="${field_pad*2+field_h+upper_box}" height="${lower_box}" width="${box_w/4}" fill="transparent"></rect>

    <text x="${box_w+button_dim+slider_pad-button_dim/2}" y="${field_pad*2+field_h+upper_box*2/3}" font-size="${2*upper_box/3}" fill="white">MAIN : ${away.shape}</text>
    <rect x="${box_w+button_dim+slider_pad-button_dim}" y="${field_pad*2+field_h}" height="${upper_box}" width="${field_w/2+field_pad/2+button_dim/2}" fill="transparent"></rect>
    <text x="${box_w+button_dim+slider_pad-button_dim/2}" y="${field_pad*2+field_h+upper_box+2*lower_box/3}" font-size="${2*lower_box/3}" fill="white">ULTRA-DEF</text>
    <text x="${box_w+button_dim+slider_pad-button_dim/2+box_w/4}" y="${field_pad*2+field_h+upper_box+2*lower_box/3}" font-size="${2*lower_box/3}" fill="white">DEFENCE</text>
    <text x="${box_w+button_dim+slider_pad-button_dim/2+2*box_w/4}" y="${field_pad*2+field_h+upper_box+2*lower_box/3}" font-size="${2*lower_box/3}" fill="white">ATTACK</text>
    <text x="${box_w+button_dim+slider_pad-button_dim/2+3*box_w/4}" y="${field_pad*2+field_h+upper_box+2*lower_box/3}" font-size="${2*lower_box/3}" fill="white">ULTRA-ATK</text>
    <rect x="${box_w+button_dim+slider_pad-button_dim}" y="${field_pad*2+field_h+upper_box}" height="${lower_box}" width="${box_w/4}" fill="transparent"></rect>
    <rect x="${box_w+button_dim+slider_pad-button_dim+box_w/4}" y="${field_pad*2+field_h+upper_box}" height="${lower_box}" width="${box_w/4}" fill="transparent"></rect>
    <rect x="${box_w+button_dim+slider_pad-button_dim+2*box_w/4}" y="${field_pad*2+field_h+upper_box}" height="${lower_box}" width="${box_w/4}" fill="transparent"></rect>
    <rect x="${box_w+button_dim+slider_pad-button_dim+3*box_w/4}" y="${field_pad*2+field_h+upper_box}" height="${lower_box}" width="${box_w/4}" fill="transparent"></rect>
    </svg>`;
    document.getElementById(`${my_id}-ball_dec`).addEventListener(`mousedown`, e=>{
      sliders.ball_pos[0] = true;
      football(home, away, ball_x, sliders);
    });
    document.getElementById(`${my_id}-ball_dec`).addEventListener(`mousemove`, e=>{
      if (sliders.ball_pos[0]) {
        football(home, away, ball_x>0 ? ball_x-0.25 : ball_x, sliders);
      }
    });
    document.getElementById(`${my_id}-ball_dec`).addEventListener(`mouseup`, e=>{
      if (sliders.ball_pos[0]) {
        sliders.ball_pos[0] = false;
        football(home, away, ball_x>0 ? ball_x-0.5 : ball_x, sliders);
      }
    });
    document.getElementById(`${my_id}-ball_inc`).addEventListener(`mousedown`, e=>{
      sliders.ball_pos[1] = true;
      football(home, away, ball_x, sliders);
    });
    document.getElementById(`${my_id}-ball_inc`).addEventListener(`mousemove`, e=>{
      if (sliders.ball_pos[1]) {
        football(home, away, ball_x<field_w ? ball_x+0.25 : ball_x, sliders);
      }
    });
    document.getElementById(`${my_id}-ball_inc`).addEventListener(`mouseup`, e=>{
      if (sliders.ball_pos[1]) {
        sliders.ball_pos[1] = false;
        football(home, away, ball_x<field_w ? ball_x+0.5 : ball_x, sliders);
      }
    });

    document.getElementById(`${my_id}-home_depth_dec`).addEventListener(`mousedown`, e=>{
      sliders.home_depth[0] = true;
      football(home, away, ball_x, sliders);
    });
    document.getElementById(`${my_id}-home_depth_dec`).addEventListener(`mousemove`, e=>{
      if (sliders.home_depth[0]) {
        home.depth = home.depth>0 ? home.depth-0.1 : home.depth;
        football(home, away, ball_x, sliders);
      }
    });
    document.getElementById(`${my_id}-home_depth_dec`).addEventListener(`mouseup`, e=>{
      if (sliders.home_depth[0]) {
        sliders.home_depth[0] = false;
        home.depth = home.depth>0 ? home.depth-0.5 : home.depth;
        football(home, away, ball_x, sliders);
      }
    });
    document.getElementById(`${my_id}-home_depth_inc`).addEventListener(`mousedown`, e=>{
      sliders.home_depth[1] = true;
      football(home, away, ball_x, sliders);
    });
    document.getElementById(`${my_id}-home_depth_inc`).addEventListener(`mousemove`, e=>{
      if (sliders.home_depth[1]) {
        home.depth = home.depth<field_w/2-2*button_dim ? home.depth+0.1 : home.depth;
        football(home, away, ball_x, sliders);
      }
    });
    document.getElementById(`${my_id}-home_depth_inc`).addEventListener(`mouseup`, e=>{
      if (sliders.home_depth[1]) {
        sliders.home_depth[1] = false;
        home.depth = home.depth<field_w/2-2*button_dim ? home.depth+0.5 : home.depth;
        football(home, away, ball_x, sliders);
      }
    });

    document.getElementById(`${my_id}-away_depth_dec`).addEventListener(`mousedown`, e=>{
      sliders.away_depth[0] = true;
      football(home, away, ball_x, sliders);
    });
    document.getElementById(`${my_id}-away_depth_dec`).addEventListener(`mousemove`, e=>{
      if (sliders.away_depth[0]) {
        away.depth = away.depth<field_w/2-2*button_dim ? away.depth+0.1 : away.depth;
        football(home, away, ball_x, sliders);
      }
    });
    document.getElementById(`${my_id}-away_depth_dec`).addEventListener(`mouseup`, e=>{
      if (sliders.away_depth[0]) {
        sliders.away_depth[0] = false;
        away.depth = away.depth<field_w/2-2*button_dim ? away.depth+0.5 : away.depth;
        football(home, away, ball_x, sliders);
      }
    });
    document.getElementById(`${my_id}-away_depth_inc`).addEventListener(`mousedown`, e=>{
      sliders.away_depth[1] = true;
      football(home, away, ball_x, sliders);
    });
    document.getElementById(`${my_id}-away_depth_inc`).addEventListener(`mousemove`, e=>{
      if (sliders.away_depth[1]) {
        away.depth = away.depth>0 ? away.depth-0.1 : away.depth;
        football(home, away, ball_x, sliders);
      }
    });
    document.getElementById(`${my_id}-away_depth_inc`).addEventListener(`mouseup`, e=>{
      if (sliders.away_depth[1]) {
        sliders.away_depth[1] = false;
        away.depth = away.depth>0 ? away.depth-0.5 : away.depth;
        football(home, away, ball_x, sliders);
      }
    });

    document.getElementById(`${my_id}-home_spread_dec`).addEventListener(`mousedown`, e=>{
      sliders.home_spread[0] = true;
      football(home, away, ball_x, sliders);
    });
    document.getElementById(`${my_id}-home_spread_dec`).addEventListener(`mousemove`, e=>{
      if (sliders.home_spread[0]) {
        home.spread = home.spread>5 ? home.spread-0.1 : home.spread;
        football(home, away, ball_x, sliders);
      }
    });
    document.getElementById(`${my_id}-home_spread_dec`).addEventListener(`mouseup`, e=>{
      if (sliders.home_spread[0]) {
        sliders.home_spread[0] = false;
        home.spread = home.spread>5 ? home.spread-0.5 : home.spread;
        football(home, away, ball_x, sliders);
      }
    });
    document.getElementById(`${my_id}-home_spread_inc`).addEventListener(`mousedown`, e=>{
      sliders.home_spread[1] = true;
      football(home, away, ball_x, sliders);
    });
    document.getElementById(`${my_id}-home_spread_inc`).addEventListener(`mousemove`, e=>{
      if (sliders.home_spread[1]) {
        home.spread = home.spread<field_h? home.spread+0.1 : home.spread;
        football(home, away, ball_x, sliders);
      }
    });
    document.getElementById(`${my_id}-home_spread_inc`).addEventListener(`mouseup`, e=>{
      if (sliders.home_spread[1]) {
        sliders.home_spread[1] = false;
        home.spread = home.spread<field_h ? home.spread+0.5 : home.spread;
        football(home, away, ball_x, sliders);
      }
    });

    document.getElementById(`${my_id}-away_spread_dec`).addEventListener(`mousedown`, e=>{
      sliders.away_spread[0] = true;
      football(home, away, ball_x, sliders);
    });
    document.getElementById(`${my_id}-away_spread_dec`).addEventListener(`mousemove`, e=>{
      if (sliders.away_spread[0]) {
        away.spread = away.spread>5 ? away.spread-0.1 : away.spread;
        football(home, away, ball_x, sliders);
      }
    });
    document.getElementById(`${my_id}-away_spread_dec`).addEventListener(`mouseup`, e=>{
      if (sliders.away_spread[0]) {
        sliders.away_spread[0] = false;
        away.spread = away.spread>5 ? away.spread-0.5 : away.spread;
        football(home, away, ball_x, sliders);
      }
    });
    document.getElementById(`${my_id}-away_spread_inc`).addEventListener(`mousedown`, e=>{
      sliders.away_spread[1] = true;
      football(home, away, ball_x, sliders);
    });
    document.getElementById(`${my_id}-away_spread_inc`).addEventListener(`mousemove`, e=>{
      if (sliders.away_spread[1]) {
        away.spread = away.spread<field_h? away.spread+0.1 : away.spread;
        football(home, away, ball_x, sliders);
      }
    });
    document.getElementById(`${my_id}-away_spread_inc`).addEventListener(`mouseup`, e=>{
      if (sliders.away_spread[1]) {
        sliders.away_spread[1] = false;
        away.spread = away.spread<field_h ? away.spread+0.5 : away.spread;
        football(home, away, ball_x, sliders);
      }
    });
}
football();
</script>

<!-- {{< svg football >}}
w := 125;
h := 84;
p := 5;
show svg(width=125, height=84) {
  (5, 5): rect(x=0, y=0, height=74, width=115, fill="gray") {
    (57.5, 0): line(x1=0, y1=0, x2=0, y2=74),
    (57.5, 37): circle(cx=0, cy=0, r=10, fill="transparent"){
      (0, 0): circle(cx=0, cy=0, r=0.4, fill="white")
    },
    (0, 37): rect(x=-3, y=-4, height=8, width=3, fill="transparent") {
      (0, 0): circle(cx=12, cy=0, r=10, fill="transparent"),
      (0, 0): rect(x=0, y=-22, height=44, width=18, fill="gray"),
      (0, 0): circle(cx=12, cy=0, r=0.4, fill="white"),
      (0, 0): rect(x=0, y=-10, height=20, width=6, fill="gray")
    },
    (115, 37): rect(x=0, y=-4, height=8, width=3, fill="transparent") {
      (0, 0): circle(cx=-12, cy=0, r=10, fill="transparent"),
      (0, 0): rect(x=-18, y=-22, height=44, width=18, fill="gray"),
      (0, 0): circle(cx=-12, cy=0, r=0.4, fill="white"),
      (0, 0): rect(x=-6, y=-10, height=20, width=6, fill="gray")
    },
    (0, 0): path(d=((0,1), (1,1), (1,0)), fill="transparent"),
    (115, 0): path(d=((0,1), (-1,1), (-1,0)), fill="transparent"),
    (115, 74): path(d=((0,-1), (-1,-1), (-1,0)), fill="transparent"),
    (0, 74): path(d=((0,-1), (1,-1), (1,0)), fill="transparent")
  }
};
{{< /svg >}} -->
