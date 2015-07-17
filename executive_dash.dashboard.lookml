- dashboard: executive_dash
  title: Executive Dash
  layout: grid
  rows: 
    - elements: [store_total, online_total]
      height: 220

    - elements: [store_regional_sales, online_regional_sales]
      height: 400
  
    - elements: [top_store_products, top_online_products]
      height: 400

    - elements: [order_rate]
      height: 400
      
  filters:
    
    - name: date
      type: date_filter
    - name: customer_type
      type: field_filter
      explore: store_sales_fact
      field: customer_dimension.customer_type
      #default_value:
    - name: measure_type
      type: field_filter
      explore: store_sales_fact
      field: store_sales_fact.measure_type
      default_value: Sales
      
      

  elements:

  - name: store_total
    title: Store total
    type: single_value
    model: vmart1
    explore: store_sales_fact
    measures: [store_sales_fact.measure_total]
    listen:
      measure_type: store_sales_fact.measure_type
      customer_type: customer_dimension.customer_type
      date: date_dimension.date_date
    sorts: [store_sales_fact.measure_total desc]
    limit: 500
    column_limit: ''
    font_size: medium
    
  - name: online_total
    title: Online Total
    type: single_value
    model: vmart1
    explore: online_sales_fact
    measures: [online_sales_fact.measure_total]
    listen: 
      customer_type: customer_dimension.customer_type
      date: date_dimension_sales.date_date
      measure_type: online_sales_fact.measure_type
    sorts: [online_sales_fact.measure_total desc]
    limit: 500
    column_limit: ''
    font_size: medium
   
  - name: top_online_products
    title: top online products
    type: looker_column
    model: vmart1
    explore: online_sales_fact
    dimensions: [product_dimension.department_description]
    measures: [online_sales_fact.measure_total]
    filters:
      online_sales_fact.transaction_type: '"purchase"'
    listen: 
      customer_type: customer_dimension.customer_type
      date: date_dimension_sales.date_date
      measure_type: online_sales_fact.measure_type
    sorts: [online_sales_fact.measure_total]
    limit: 10
    column_limit: ''
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false
  
  - name: top_store_products
    title: top store products
    type: looker_column
    model: vmart1
    explore: store_sales_fact
    dimensions: [product_dimension.store_department_description]
    measures: [store_sales_fact.measure_total]
    filters:
      store_sales_fact.transaction_type: '"purchase"'
    
    listen:
      measure_type: store_sales_fact.measure_type
      customer_type: customer_dimension.customer_type
      date: date_dimension.date_date
    
    sorts: [store_sales_fact.measure_total desc]
    limit: 500
    column_limit: ''
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false

  - name: store_regional_sales
    title: Store regional totals
    type: looker_geo_choropleth
    model: vmart1
    explore: store_sales_fact
    dimensions: [customer_dimension.customer_state]
    measures: [store_sales_fact.measure_total]
    listen:
      measure_type: store_sales_fact.measure_type
      customer_type: customer_dimension.customer_type
      date: date_dimension.date_date
    sorts: [store_sales_fact.measure_total desc]
    limit: 500
    column_limit: ''
    show_view_names: true
    quantize_colors: false
    colors: ['#008000']
    map: usa
    map_projection: ''
    loading: false

  - name: online_regional_sales
    title: Online Regional totals
    type: looker_geo_choropleth
    model: vmart1
    explore: online_sales_fact
    dimensions: [customer_dimension.customer_state]
    measures: [online_sales_fact.total_sales]
    listen:
      customer_type: customer_dimension.customer_type
      date: date_dimension_sales.date_date
      measure_type: online_sales_fact.measure_type
    sorts: [online_sales_fact.total_sales desc]
    limit: 500
    column_limit: ''
    total: true
    map: usa
    map_projection: ''
    show_view_names: true
    quantize_colors: false
    colors: []
    loading: false
    
  - name: order_rate
    title: Perfect Order Rate by vendor
    type: looker_column
    model: vmart1
    explore: store_orders_fact
    dimensions: [vendor_dimension.vendor_name]
    measures: [store_orders_fact.perfect_order_rate]
    listen: 
      date: store_orders_fact.date_delivered_date
    sorts: [store_orders_fact.perfect_order_rate desc]
    limit: 500
    column_limit: ''
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_max: ['1']
    y_axis_min: ['0']
    stacking: ''
    show_value_labels: false
    x_axis_gridlines: false
    show_view_names: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    x_axis_scale: auto
    show_null_labels: false