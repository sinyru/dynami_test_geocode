# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "plv8"

  create_table "acalitem", primary_key: "acalitem_id", id: :integer, default: -> { "nextval(('\"xcalitem_xcalitem_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Absolute Calendar Item information" do |t|
    t.integer "acalitem_calhead_id"
    t.date    "acalitem_periodstart"
    t.integer "acalitem_periodlength"
    t.text    "acalitem_name"
  end

  create_table "accnt", primary_key: "accnt_id", id: :integer, default: -> { "nextval(('accnt_accnt_id_seq'::text)::regclass)" }, force: :cascade, comment: "General Ledger (G/L) Account Number information" do |t|
    t.text    "accnt_number"
    t.text    "accnt_descrip"
    t.text    "accnt_comments"
    t.text    "accnt_profit"
    t.text    "accnt_sub"
    t.string  "accnt_type",              limit: 1,                                 null: false
    t.text    "accnt_extref"
    t.text    "accnt_company"
    t.boolean "accnt_forwardupdate"
    t.text    "accnt_subaccnttype_code"
    t.integer "accnt_curr_id",                     default: -> { "basecurrid()" }
    t.boolean "accnt_active",                      default: true,                  null: false
    t.text    "accnt_name"
    t.index ["accnt_number", "accnt_profit", "accnt_sub", "accnt_company"], name: "accnt_unique_idx", unique: true, using: :btree
  end

  create_table "addr", primary_key: "addr_id", force: :cascade, comment: "Postal Address" do |t|
    t.boolean "addr_active",     default: true
    t.text    "addr_line1",      default: ""
    t.text    "addr_line2",      default: ""
    t.text    "addr_line3",      default: ""
    t.text    "addr_city",       default: ""
    t.text    "addr_state",      default: ""
    t.text    "addr_postalcode", default: ""
    t.text    "addr_country",    default: ""
    t.text    "addr_notes",      default: ""
    t.text    "addr_number",                    null: false
    t.index ["addr_number"], name: "addr_addr_number_key", unique: true, using: :btree
  end

  create_table "alarm", primary_key: "alarm_id", force: :cascade, comment: "This table is the open alarms." do |t|
    t.text     "alarm_number",                           null: false
    t.boolean  "alarm_event",            default: false, null: false
    t.boolean  "alarm_email",            default: false, null: false
    t.boolean  "alarm_sysmsg",           default: false, null: false
    t.datetime "alarm_trigger"
    t.datetime "alarm_time"
    t.integer  "alarm_time_offset"
    t.text     "alarm_time_qualifier"
    t.text     "alarm_creator"
    t.text     "alarm_event_recipient"
    t.text     "alarm_email_recipient"
    t.text     "alarm_sysmsg_recipient"
    t.text     "alarm_source"
    t.integer  "alarm_source_id"
  end

  create_table "apaccnt", primary_key: "apaccnt_id", force: :cascade, comment: "Accounts Payable (A/P) Account assignment information" do |t|
    t.integer "apaccnt_vendtype_id"
    t.text    "apaccnt_vendtype"
    t.integer "apaccnt_ap_accnt_id",       null: false
    t.integer "apaccnt_prepaid_accnt_id"
    t.integer "apaccnt_discount_accnt_id"
  end

  create_table "apapply", primary_key: "apapply_id", force: :cascade, comment: "Applications (e.g., Payments, A/P Credit Memos) made to Accounts Payable (A/P) Documents" do |t|
    t.integer "apapply_vend_id"
    t.date    "apapply_postdate"
    t.text    "apapply_username"
    t.integer "apapply_source_apopen_id",                                                          comment: "If apapply_source_doctype is \"C\" (credit memo) then apapply_source_apopen_id acts as a foreign key to the apopen table. If the source doctype is \"K\" (check) then the apapply_source_apopen_id acts as a foreign key to the checkhead table. If the apapply_source_apopen_id is -1 then the internal id of the source document is not known (always the case for checks posted before release 3.2.0BETA)."
    t.text    "apapply_source_doctype"
    t.text    "apapply_source_docnumber"
    t.integer "apapply_target_apopen_id"
    t.text    "apapply_target_doctype"
    t.text    "apapply_target_docnumber"
    t.integer "apapply_journalnumber"
    t.decimal "apapply_amount",           precision: 20, scale: 2
    t.integer "apapply_curr_id",                                   default: -> { "basecurrid()" }
    t.decimal "apapply_target_paid",      precision: 20, scale: 2
    t.integer "apapply_checkhead_id"
  end

  create_table "apcreditapply", primary_key: "apcreditapply_id", force: :cascade, comment: "Temporary table for storing details of Accounts Payable (A/P) Credit Memo applications before those applications are posted" do |t|
    t.integer "apcreditapply_source_apopen_id"
    t.integer "apcreditapply_target_apopen_id"
    t.decimal "apcreditapply_amount",           precision: 20, scale: 2
    t.integer "apcreditapply_curr_id",                                   default: -> { "basecurrid()" }
  end

  create_table "apopen", primary_key: "apopen_id", id: :integer, default: -> { "nextval(('\"apopen_apopen_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Accounts Payable (A/P) open Items information" do |t|
    t.date    "apopen_docdate"
    t.date    "apopen_duedate"
    t.integer "apopen_terms_id"
    t.integer "apopen_vend_id"
    t.string  "apopen_doctype",             limit: 1
    t.text    "apopen_docnumber"
    t.decimal "apopen_amount",                        precision: 20, scale: 2
    t.text    "apopen_notes"
    t.boolean "apopen_posted"
    t.text    "apopen_reference"
    t.text    "apopen_invcnumber"
    t.text    "apopen_ponumber"
    t.integer "apopen_journalnumber"
    t.decimal "apopen_paid",                          precision: 20, scale: 2, default: "0.0"
    t.boolean "apopen_open"
    t.text    "apopen_username"
    t.boolean "apopen_discount",                                               default: false,                 null: false
    t.integer "apopen_accnt_id",                                               default: -1
    t.integer "apopen_curr_id",                                                default: -> { "basecurrid()" }
    t.date    "apopen_closedate"
    t.date    "apopen_distdate"
    t.boolean "apopen_void",                                                   default: false,                 null: false
    t.decimal "apopen_curr_rate",                                                                              null: false
    t.decimal "apopen_discountable_amount",           precision: 20, scale: 2, default: "0.0"
    t.text    "apopen_status"
    t.index ["apopen_open"], name: "apopen_apopen_open_idx", using: :btree
    t.index ["apopen_vend_id"], name: "apopen_apopen_vend_id_idx", using: :btree
  end

  create_table "apopentax", primary_key: "taxhist_id", id: :integer, default: -> { "nextval('taxhist_taxhist_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "taxhist_parent_id",                              null: false
    t.integer "taxhist_taxtype_id"
    t.integer "taxhist_tax_id",                                 null: false
    t.decimal "taxhist_basis",         precision: 16, scale: 2, null: false
    t.integer "taxhist_basis_tax_id"
    t.integer "taxhist_sequence"
    t.decimal "taxhist_percent",       precision: 10, scale: 6, null: false
    t.decimal "taxhist_amount",        precision: 16, scale: 2, null: false
    t.decimal "taxhist_tax",           precision: 16, scale: 6, null: false
    t.date    "taxhist_docdate",                                null: false
    t.date    "taxhist_distdate"
    t.integer "taxhist_curr_id"
    t.decimal "taxhist_curr_rate"
    t.integer "taxhist_journalnumber"
    t.index ["taxhist_parent_id", "taxhist_taxtype_id"], name: "apopentax_taxhist_parent_type_idx", using: :btree
    t.index ["taxhist_parent_id"], name: "apopentax_taxhist_parent_id_idx", using: :btree
    t.index ["taxhist_taxtype_id"], name: "apopentax_taxhist_taxtype_id_idx", using: :btree
  end

  create_table "apselect", primary_key: "apselect_id", force: :cascade, comment: "Temporary table for storing details of Accounts Payable (A/P) Payment selections" do |t|
    t.integer "apselect_apopen_id",                                                             null: false
    t.decimal "apselect_amount",       precision: 20, scale: 2,                                 null: false
    t.integer "apselect_bankaccnt_id"
    t.integer "apselect_curr_id",                               default: -> { "basecurrid()" }
    t.date    "apselect_date"
    t.decimal "apselect_discount",     precision: 20, scale: 2, default: "0.0",                 null: false
    t.index ["apselect_apopen_id"], name: "apselect_apselect_apopen_id_idx", using: :btree
    t.index ["apselect_apopen_id"], name: "apselect_apselect_apopen_id_key", unique: true, using: :btree
  end

  create_table "araccnt", primary_key: "araccnt_id", id: :integer, default: -> { "nextval(('araccnt_araccnt_id_seq'::text)::regclass)" }, force: :cascade, comment: "Accounts Receivable (A/R) Account assignment information" do |t|
    t.integer "araccnt_custtype_id"
    t.text    "araccnt_custtype"
    t.integer "araccnt_freight_accnt_id"
    t.integer "araccnt_ar_accnt_id"
    t.integer "araccnt_prepaid_accnt_id"
    t.integer "araccnt_deferred_accnt_id"
    t.integer "araccnt_discount_accnt_id"
  end

  create_table "arapply", primary_key: "arapply_id", force: :cascade, comment: "Applications (e.g., Cash Receipts, A/R Credit Memos) made to Accounts Receivable (A/R) Documents" do |t|
    t.date    "arapply_postdate"
    t.integer "arapply_cust_id"
    t.text    "arapply_source_doctype"
    t.text    "arapply_source_docnumber"
    t.text    "arapply_target_doctype"
    t.text    "arapply_target_docnumber"
    t.text    "arapply_fundstype"
    t.text    "arapply_refnumber"
    t.decimal "arapply_applied",          precision: 20, scale: 2
    t.boolean "arapply_closed"
    t.text    "arapply_journalnumber"
    t.integer "arapply_source_aropen_id"
    t.integer "arapply_target_aropen_id"
    t.text    "arapply_username"
    t.integer "arapply_curr_id",                                   default: -> { "basecurrid()" }
    t.date    "arapply_distdate",                                                                  null: false
    t.decimal "arapply_target_paid",      precision: 20, scale: 2
    t.text    "arapply_reftype"
    t.integer "arapply_ref_id"
    t.index ["arapply_target_docnumber"], name: "arapply_arapply_target_docnumber_idx", using: :btree
  end

  create_table "arcreditapply", primary_key: "arcreditapply_id", id: :integer, default: -> { "nextval('cashrcptitem_cashrcptitem_id_seq'::regclass)" }, force: :cascade, comment: "Temporary table for storing details of Accounts Receivable (A/R) Credit Memo applications before those applications are posted" do |t|
    t.integer "arcreditapply_source_aropen_id"
    t.integer "arcreditapply_target_aropen_id"
    t.decimal "arcreditapply_amount",           precision: 20, scale: 2
    t.integer "arcreditapply_curr_id",                                   default: -> { "basecurrid()" }
    t.text    "arcreditapply_reftype"
    t.integer "arcreditapply_ref_id"
  end

  create_table "aropen", primary_key: "aropen_id", id: :integer, default: -> { "nextval(('\"aropen_aropen_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Accounts Receivable (A/R) open Items information" do |t|
    t.date    "aropen_docdate",                                                                            null: false
    t.date    "aropen_duedate",                                                                            null: false
    t.integer "aropen_terms_id"
    t.integer "aropen_cust_id"
    t.string  "aropen_doctype",         limit: 1
    t.text    "aropen_docnumber"
    t.text    "aropen_applyto"
    t.text    "aropen_ponumber"
    t.decimal "aropen_amount",                    precision: 20, scale: 2,                                 null: false
    t.text    "aropen_notes"
    t.boolean "aropen_posted",                                             default: false,                 null: false
    t.integer "aropen_salesrep_id"
    t.decimal "aropen_commission_due",            precision: 20, scale: 2
    t.boolean "aropen_commission_paid",                                    default: false
    t.text    "aropen_ordernumber"
    t.integer "aropen_cobmisc_id",                                         default: -1
    t.integer "aropen_journalnumber"
    t.decimal "aropen_paid",                      precision: 20, scale: 2, default: "0.0"
    t.boolean "aropen_open"
    t.text    "aropen_username"
    t.integer "aropen_rsncode_id"
    t.integer "aropen_salescat_id",                                        default: -1
    t.integer "aropen_accnt_id",                                           default: -1
    t.integer "aropen_curr_id",                                            default: -> { "basecurrid()" }
    t.date    "aropen_closedate"
    t.date    "aropen_distdate"
    t.decimal "aropen_curr_rate",                                                                          null: false
    t.boolean "aropen_discount",                                           default: false,                 null: false
    t.date    "aropen_fincharg_date"
    t.decimal "aropen_fincharg_amount",           precision: 20, scale: 2
    t.index ["aropen_cust_id"], name: "aropen_aropen_cust_id_idx", using: :btree
    t.index ["aropen_docnumber"], name: "aropen_aropen_docnumber_idx", using: :btree
    t.index ["aropen_doctype"], name: "aropen_aropen_doctype_idx", using: :btree
    t.index ["aropen_open"], name: "aropen_aropen_open_idx", using: :btree
    t.index ["aropen_posted"], name: "aropen_posted_idx", using: :btree
  end

  create_table "aropenalloc", primary_key: ["aropenalloc_aropen_id", "aropenalloc_doctype", "aropenalloc_doc_id"], force: :cascade do |t|
    t.integer "aropenalloc_aropen_id",                                                                    null: false
    t.string  "aropenalloc_doctype",   limit: 1,                                                          null: false
    t.integer "aropenalloc_doc_id",                                                                       null: false
    t.decimal "aropenalloc_amount",              precision: 20, scale: 2, default: "0.0",                 null: false
    t.integer "aropenalloc_curr_id",                                      default: -> { "basecurrid()" }
    t.index ["aropenalloc_aropen_id"], name: "aropenalloc_aropen_id_idx", using: :btree
    t.index ["aropenalloc_doc_id"], name: "aropenalloc_doc_id_idx", using: :btree
  end

  create_table "aropentax", primary_key: "taxhist_id", id: :integer, default: -> { "nextval('taxhist_taxhist_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "taxhist_parent_id",                              null: false
    t.integer "taxhist_taxtype_id"
    t.integer "taxhist_tax_id",                                 null: false
    t.decimal "taxhist_basis",         precision: 16, scale: 2, null: false
    t.integer "taxhist_basis_tax_id"
    t.integer "taxhist_sequence"
    t.decimal "taxhist_percent",       precision: 10, scale: 6, null: false
    t.decimal "taxhist_amount",        precision: 16, scale: 2, null: false
    t.decimal "taxhist_tax",           precision: 16, scale: 6, null: false
    t.date    "taxhist_docdate",                                null: false
    t.date    "taxhist_distdate"
    t.integer "taxhist_curr_id"
    t.decimal "taxhist_curr_rate"
    t.integer "taxhist_journalnumber"
    t.index ["taxhist_parent_id", "taxhist_taxtype_id"], name: "aropentax_taxhist_parent_type_idx", using: :btree
    t.index ["taxhist_parent_id"], name: "aropentax_taxhist_parent_id_idx", using: :btree
    t.index ["taxhist_taxtype_id"], name: "aropentax_taxhist_taxtype_id_idx", using: :btree
  end

  create_table "asohist", primary_key: "asohist_id", force: :cascade, comment: "Archived Sales history" do |t|
    t.integer "asohist_cust_id"
    t.integer "asohist_itemsite_id"
    t.date    "asohist_shipdate"
    t.date    "asohist_invcdate"
    t.date    "asohist_duedate"
    t.date    "asohist_promisedate"
    t.text    "asohist_ordernumber"
    t.text    "asohist_invcnumber"
    t.decimal "asohist_qtyshipped",               precision: 18, scale: 6
    t.decimal "asohist_unitprice",                precision: 16, scale: 4
    t.decimal "asohist_unitcost",                 precision: 16, scale: 6
    t.text    "asohist_billtoname"
    t.text    "asohist_billtoaddress1"
    t.text    "asohist_billtoaddress2"
    t.text    "asohist_billtoaddress3"
    t.text    "asohist_billtocity"
    t.text    "asohist_billtostate"
    t.text    "asohist_billtozip"
    t.text    "asohist_shiptoname"
    t.text    "asohist_shiptoaddress1"
    t.text    "asohist_shiptoaddress2"
    t.text    "asohist_shiptoaddress3"
    t.text    "asohist_shiptocity"
    t.text    "asohist_shiptostate"
    t.text    "asohist_shiptozip"
    t.integer "asohist_shipto_id"
    t.text    "asohist_shipvia"
    t.integer "asohist_salesrep_id"
    t.string  "asohist_misc_type",      limit: 1
    t.text    "asohist_misc_descrip"
    t.integer "asohist_misc_id"
    t.decimal "asohist_commission",               precision: 16, scale: 4
    t.boolean "asohist_commissionpaid"
    t.text    "asohist_doctype"
    t.date    "asohist_orderdate"
    t.boolean "asohist_imported"
    t.text    "asohist_ponumber"
    t.integer "asohist_curr_id",                                           default: -> { "basecurrid()" }
    t.integer "asohist_taxtype_id"
    t.integer "asohist_taxzone_id"
  end

  create_table "asohisttax", primary_key: "taxhist_id", id: :integer, default: -> { "nextval('taxhist_taxhist_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "taxhist_parent_id",                              null: false
    t.integer "taxhist_taxtype_id"
    t.integer "taxhist_tax_id",                                 null: false
    t.decimal "taxhist_basis",         precision: 16, scale: 2, null: false
    t.integer "taxhist_basis_tax_id"
    t.integer "taxhist_sequence"
    t.decimal "taxhist_percent",       precision: 10, scale: 6, null: false
    t.decimal "taxhist_amount",        precision: 16, scale: 2, null: false
    t.decimal "taxhist_tax",           precision: 16, scale: 6, null: false
    t.date    "taxhist_docdate",                                null: false
    t.date    "taxhist_distdate"
    t.integer "taxhist_curr_id"
    t.decimal "taxhist_curr_rate"
    t.integer "taxhist_journalnumber"
    t.index ["taxhist_parent_id", "taxhist_taxtype_id"], name: "asohisttax_taxhist_parent_type_idx", using: :btree
    t.index ["taxhist_parent_id"], name: "asohisttax_taxhist_parent_id_idx", using: :btree
    t.index ["taxhist_taxtype_id"], name: "asohisttax_taxhist_taxtype_id_idx", using: :btree
  end

  create_table "atlasmap", primary_key: "atlasmap_id", force: :cascade, comment: "Describes heuristics for finding a CSVImp atlas for a given CSV file. When looking for a CSV Atlas to use when importing a CSV file, the first atlasmap record found that matches the CSV file is used to select the Atlas file and Map in that Atlas to import the CSV file." do |t|
    t.text    "atlasmap_name",                       null: false, comment: "The human-readable name of this atlas mapping."
    t.text    "atlasmap_filter",                     null: false, comment: "A regular expression that should match the CSV file. Which part of the file that matches is determined by the filter type."
    t.text    "atlasmap_filtertype",                 null: false, comment: "A description of what aspect of the CSV file the filter should be compared with. Handled values are: 'filename' - the filter is matched against the name of the file; and 'firstline' - the filter is matched against the first line of the file contents."
    t.text    "atlasmap_atlas",                      null: false, comment: "The name of the CSVImp Atlas file. This should be a simple pathname, not an absolute or relative name if possible. The full path will be determined by concatenating the operating-system-specific CSV Atlas default directory with the value here unless this is an absolute pathname."
    t.text    "atlasmap_map",                        null: false, comment: "The name of the Map inside the Atlas to use if the filter and filter type match the CVS file."
    t.boolean "atlasmap_headerline", default: false, null: false, comment: "An indicator of whether the first line of the CSV file should be treated as a header line or as data."
    t.index ["atlasmap_name"], name: "atlasmap_atlasmap_name_key", unique: true, using: :btree
  end

  create_table "backup_usr", id: false, force: :cascade do |t|
    t.integer "usr_id"
    t.text    "usr_username"
    t.text    "usr_propername"
    t.text    "usr_passwd"
    t.integer "usr_locale_id"
    t.text    "usr_initials"
    t.boolean "usr_agent"
    t.boolean "usr_active"
    t.text    "usr_email"
    t.integer "usr_dept_id"
    t.integer "usr_shift_id"
    t.text    "usr_window"
  end

  create_table "bankaccnt", primary_key: "bankaccnt_id", force: :cascade, comment: "Bank Account information" do |t|
    t.text    "bankaccnt_name",                                                      null: false
    t.text    "bankaccnt_descrip"
    t.text    "bankaccnt_bankname"
    t.text    "bankaccnt_accntnumber"
    t.boolean "bankaccnt_ar"
    t.boolean "bankaccnt_ap"
    t.integer "bankaccnt_nextchknum"
    t.string  "bankaccnt_type",            limit: 1
    t.integer "bankaccnt_accnt_id"
    t.integer "bankaccnt_check_form_id"
    t.boolean "bankaccnt_userec"
    t.integer "bankaccnt_rec_accnt_id"
    t.integer "bankaccnt_curr_id",                   default: -> { "basecurrid()" }
    t.text    "bankaccnt_notes"
    t.text    "bankaccnt_routing",                   default: "",                    null: false
    t.boolean "bankaccnt_ach_enabled",               default: false,                 null: false
    t.text    "bankaccnt_ach_origin",                default: "",                    null: false
    t.boolean "bankaccnt_ach_genchecknum",           default: false,                 null: false
    t.integer "bankaccnt_ach_leadtime"
    t.date    "bankaccnt_ach_lastdate"
    t.string  "bankaccnt_ach_lastfileid",  limit: 1
    t.text    "bankaccnt_ach_origintype"
    t.text    "bankaccnt_ach_originname"
    t.text    "bankaccnt_ach_desttype"
    t.text    "bankaccnt_ach_fed_dest"
    t.text    "bankaccnt_ach_destname"
    t.text    "bankaccnt_ach_dest"
    t.boolean "bankaccnt_prnt_check",                default: true,                  null: false
    t.index ["bankaccnt_name"], name: "bankaccnt_bankaccnt_name_key", unique: true, using: :btree
  end

  create_table "bankadj", primary_key: "bankadj_id", force: :cascade, comment: "Bank Adjustments information" do |t|
    t.integer  "bankadj_bankaccnt_id",                                                                    null: false
    t.integer  "bankadj_bankadjtype_id",                                                                  null: false
    t.datetime "bankadj_created",                                 default: -> { "now()" },                null: false
    t.text     "bankadj_username",                                default: -> { "geteffectivextuser()" }, null: false
    t.date     "bankadj_date",                                                                            null: false
    t.text     "bankadj_docnumber"
    t.decimal  "bankadj_amount",         precision: 10, scale: 2,                                         null: false
    t.text     "bankadj_notes"
    t.integer  "bankadj_sequence"
    t.boolean  "bankadj_posted",                                  default: false,                         null: false
    t.integer  "bankadj_curr_id",                                 default: -> { "basecurrid()" }
    t.decimal  "bankadj_curr_rate"
  end

  create_table "bankadjtype", primary_key: "bankadjtype_id", force: :cascade, comment: "Bank Adjustment Types information" do |t|
    t.text    "bankadjtype_name",                     null: false
    t.text    "bankadjtype_descrip"
    t.integer "bankadjtype_accnt_id",                 null: false
    t.boolean "bankadjtype_iscredit", default: false, null: false
    t.index ["bankadjtype_name"], name: "bankadjtype_bankadjtype_name_key", unique: true, using: :btree
  end

  create_table "bankrec", primary_key: "bankrec_id", force: :cascade, comment: "Bank Reconciliation posting history" do |t|
    t.datetime "bankrec_created",                               default: -> { "('now'::text)::timestamp(6) with time zone" }, null: false
    t.text     "bankrec_username",                              default: -> { "geteffectivextuser()" },                       null: false
    t.integer  "bankrec_bankaccnt_id"
    t.date     "bankrec_opendate"
    t.date     "bankrec_enddate"
    t.decimal  "bankrec_openbal",      precision: 20, scale: 2
    t.decimal  "bankrec_endbal",       precision: 20, scale: 2
    t.boolean  "bankrec_posted",                                default: false
    t.datetime "bankrec_postdate"
  end

  create_table "bankrecimport", primary_key: "bankrecimport_id", force: :cascade do |t|
    t.text    "bankrecimport_reference"
    t.text    "bankrecimport_descrip"
    t.text    "bankrecimport_comment"
    t.decimal "bankrecimport_debit_amount"
    t.decimal "bankrecimport_credit_amount"
    t.date    "bankrecimport_effdate"
    t.decimal "bankrecimport_curr_rate"
  end

  create_table "bankrecitem", primary_key: "bankrecitem_id", force: :cascade, comment: "Posted Bank Reconciliation Line Item information" do |t|
    t.integer "bankrecitem_bankrec_id",                 null: false
    t.text    "bankrecitem_source",                     null: false
    t.integer "bankrecitem_source_id",                  null: false
    t.boolean "bankrecitem_cleared",    default: false
    t.decimal "bankrecitem_curr_rate"
    t.decimal "bankrecitem_amount"
    t.date    "bankrecitem_effdate"
  end

  create_table "bomhead", primary_key: "bomhead_id", id: :integer, default: -> { "nextval(('\"bomhead_bomhead_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Bill of Materials (BOM) header information" do |t|
    t.integer "bomhead_item_id",                                              null: false
    t.integer "bomhead_serial"
    t.text    "bomhead_docnum"
    t.text    "bomhead_revision"
    t.date    "bomhead_revisiondate"
    t.decimal "bomhead_batchsize",      precision: 18, scale: 6
    t.decimal "bomhead_requiredqtyper", precision: 20, scale: 8
    t.integer "bomhead_rev_id",                                  default: -1
  end

  create_table "bomhist", primary_key: "bomhist_id", force: :cascade, comment: "An archive table for storing a multi-level bom detail snapshot when a revsion is deactivated" do |t|
    t.integer "bomhist_seq_id"
    t.integer "bomhist_rev_id"
    t.integer "bomhist_seqnumber"
    t.integer "bomhist_item_id"
    t.string  "bomhist_item_type",        limit: 1
    t.decimal "bomhist_qtyper",                     precision: 20, scale: 8
    t.decimal "bomhist_scrap",                      precision: 20, scale: 10
    t.string  "bomhist_status",           limit: 1
    t.integer "bomhist_level"
    t.integer "bomhist_parent_id"
    t.date    "bomhist_effective"
    t.date    "bomhist_expires"
    t.decimal "bomhist_stdunitcost",                precision: 16, scale: 6
    t.decimal "bomhist_actunitcost",                precision: 16, scale: 6
    t.integer "bomhist_parent_seqnumber"
    t.boolean "bomhist_createwo"
    t.string  "bomhist_issuemethod",      limit: 1
    t.integer "bomhist_char_id"
    t.text    "bomhist_value"
    t.text    "bomhist_notes"
    t.text    "bomhist_ref"
    t.decimal "bomhist_qtyfxd",                     precision: 20, scale: 8,  default: "0.0", null: false, comment: "The fixed quantity required"
    t.decimal "bomhist_qtyreq",                     precision: 20, scale: 8,  default: "0.0", null: false, comment: "The total quantity required"
  end

  create_table "bomitem", primary_key: "bomitem_id", id: :integer, default: -> { "nextval(('bomitem_bomitem_id_seq'::text)::regclass)" }, force: :cascade, comment: "Bill of Materials (BOM) component Items information" do |t|
    t.integer "bomitem_parent_item_id",                                                    null: false
    t.integer "bomitem_seqnumber"
    t.integer "bomitem_item_id",                                                           null: false
    t.decimal "bomitem_qtyper",                   precision: 20, scale: 8,                 null: false
    t.decimal "bomitem_scrap",                    precision: 8,  scale: 4,                 null: false
    t.string  "bomitem_status",         limit: 1
    t.date    "bomitem_effective",                                                         null: false
    t.date    "bomitem_expires",                                                           null: false
    t.boolean "bomitem_createwo",                                                          null: false
    t.string  "bomitem_issuemethod",    limit: 1,                                          null: false
    t.boolean "bomitem_schedatwooper",                                                     null: false
    t.text    "bomitem_ecn"
    t.date    "bomitem_moddate"
    t.string  "bomitem_subtype",        limit: 1,                                          null: false
    t.integer "bomitem_uom_id",                                                            null: false
    t.integer "bomitem_rev_id",                                            default: -1
    t.integer "bomitem_booitem_seq_id",                                    default: -1
    t.integer "bomitem_char_id"
    t.text    "bomitem_value"
    t.text    "bomitem_notes"
    t.text    "bomitem_ref"
    t.decimal "bomitem_qtyfxd",                   precision: 20, scale: 8, default: "0.0", null: false, comment: "The fixed quantity required"
    t.boolean "bomitem_issuewo",                                           default: false, null: false
    t.index ["bomitem_effective"], name: "bomitem_effective_key", using: :btree
    t.index ["bomitem_expires"], name: "bomitem_expires_key", using: :btree
    t.index ["bomitem_item_id"], name: "bomitem_bomitem_item_id_idx", using: :btree
    t.index ["bomitem_parent_item_id"], name: "bomitem_parent_item_id", using: :btree
  end

  create_table "bomitemcost", primary_key: "bomitemcost_id", force: :cascade, comment: "Bomitem Cost information" do |t|
    t.integer "bomitemcost_bomitem_id",                                                           null: false
    t.integer "bomitemcost_costelem_id",                                                          null: false
    t.boolean "bomitemcost_lowlevel",                             default: false,                 null: false
    t.decimal "bomitemcost_stdcost",     precision: 16, scale: 6, default: "0.0",                 null: false
    t.date    "bomitemcost_posted"
    t.decimal "bomitemcost_actcost",     precision: 16, scale: 6, default: "0.0",                 null: false
    t.date    "bomitemcost_updated"
    t.integer "bomitemcost_curr_id",                              default: -> { "basecurrid()" }, null: false
    t.index ["bomitemcost_bomitem_id", "bomitemcost_costelem_id", "bomitemcost_lowlevel"], name: "bomitemcost_master_idx", unique: true, using: :btree
    t.index ["bomitemcost_bomitem_id"], name: "bomitemcost_bomitem_id_key", using: :btree
  end

  create_table "bomitemsub", primary_key: "bomitemsub_id", force: :cascade, comment: "Bill of Materials (BOM) defined Substitutions information" do |t|
    t.integer "bomitemsub_bomitem_id",                           null: false
    t.integer "bomitemsub_item_id",                              null: false
    t.decimal "bomitemsub_uomratio",   precision: 20, scale: 10, null: false
    t.integer "bomitemsub_rank",                                 null: false
  end

  create_table "bomwork", primary_key: "bomwork_id", force: :cascade, comment: "Temporary table for storing information requested by Bill of Materials (BOM) displays and reports" do |t|
    t.integer "bomwork_set_id"
    t.integer "bomwork_seqnumber"
    t.integer "bomwork_item_id"
    t.string  "bomwork_item_type",        limit: 1
    t.decimal "bomwork_qtyper",                     precision: 20, scale: 8
    t.decimal "bomwork_scrap",                      precision: 20, scale: 10
    t.string  "bomwork_status",           limit: 1
    t.integer "bomwork_level"
    t.integer "bomwork_parent_id"
    t.date    "bomwork_effective"
    t.date    "bomwork_expires"
    t.decimal "bomwork_stdunitcost",                precision: 16, scale: 6
    t.decimal "bomwork_actunitcost",                precision: 16, scale: 6
    t.integer "bomwork_parent_seqnumber"
    t.boolean "bomwork_createwo"
    t.string  "bomwork_issuemethod",      limit: 1
    t.integer "bomwork_char_id"
    t.text    "bomwork_value"
    t.text    "bomwork_notes"
    t.text    "bomwork_ref"
    t.integer "bomwork_bomitem_id"
    t.text    "bomwork_ecn"
    t.decimal "bomwork_qtyfxd",                     precision: 20, scale: 8,  default: "0.0", null: false, comment: "The fixed quantity required"
    t.decimal "bomwork_qtyreq",                     precision: 20, scale: 8,  default: "0.0", null: false, comment: "The total quantity required"
  end

  create_table "budghead", primary_key: "budghead_id", force: :cascade do |t|
    t.text "budghead_name",    null: false
    t.text "budghead_descrip"
    t.index ["budghead_name"], name: "budghead_budghead_name_key", unique: true, using: :btree
  end

  create_table "budgitem", primary_key: "budgitem_id", force: :cascade do |t|
    t.integer "budgitem_budghead_id",                          null: false
    t.integer "budgitem_period_id",                            null: false
    t.integer "budgitem_accnt_id",                             null: false
    t.decimal "budgitem_amount",      precision: 20, scale: 4, null: false
  end

  create_table "calhead", primary_key: "calhead_id", id: :integer, default: -> { "nextval(('\"calhead_calhead_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Calendar header information" do |t|
    t.string "calhead_type",    limit: 1
    t.text   "calhead_name",              null: false
    t.text   "calhead_descrip"
    t.string "calhead_origin",  limit: 1
  end

  create_table "cashrcpt", primary_key: "cashrcpt_id", force: :cascade, comment: "Temporary table for storing Cash Receipt information before Cash Receipts are posted" do |t|
    t.integer "cashrcpt_cust_id",                                                                                  null: false
    t.decimal "cashrcpt_amount",                   precision: 20, scale: 2,                                        null: false
    t.string  "cashrcpt_fundstype",      limit: 1,                                                                 null: false
    t.text    "cashrcpt_docnumber"
    t.integer "cashrcpt_bankaccnt_id",                                                                             null: false
    t.text    "cashrcpt_notes"
    t.date    "cashrcpt_distdate",                                          default: -> { "('now'::text)::date" }
    t.integer "cashrcpt_salescat_id",                                       default: -1
    t.integer "cashrcpt_curr_id",                                           default: -> { "basecurrid()" }
    t.boolean "cashrcpt_usecustdeposit",                                    default: false,                        null: false
    t.boolean "cashrcpt_void",                                              default: false,                        null: false
    t.text    "cashrcpt_number",                                                                                   null: false
    t.date    "cashrcpt_docdate"
    t.boolean "cashrcpt_posted",                                            default: false,                        null: false
    t.date    "cashrcpt_posteddate"
    t.text    "cashrcpt_postedby"
    t.date    "cashrcpt_applydate"
    t.decimal "cashrcpt_discount",                 precision: 20, scale: 2, default: "0.0",                        null: false
    t.decimal "cashrcpt_curr_rate",                                                                                null: false
    t.decimal "cashrcpt_alt_curr_rate"
    t.index ["cashrcpt_number"], name: "cashrcpt_cashrcpt_number_key", unique: true, using: :btree
  end

  create_table "cashrcptitem", primary_key: "cashrcptitem_id", force: :cascade, comment: "Temporary table for storing information about applications of Cash Receipts before Cash Receipts are posted" do |t|
    t.integer "cashrcptitem_cashrcpt_id",                                          null: false
    t.integer "cashrcptitem_aropen_id",                                            null: false
    t.decimal "cashrcptitem_amount",      precision: 20, scale: 2,                 null: false
    t.decimal "cashrcptitem_discount",    precision: 20, scale: 2, default: "0.0", null: false
    t.boolean "cashrcptitem_applied",                              default: true
    t.index ["cashrcptitem_aropen_id"], name: "cashrcptitem_aropen_idx", using: :btree
    t.index ["cashrcptitem_cashrcpt_id"], name: "cashrcptitem_cashrcpt_idx", using: :btree
  end

  create_table "cashrcptmisc", primary_key: "cashrcptmisc_id", force: :cascade, comment: "Cash Receipt Miscellaneous Application information" do |t|
    t.integer "cashrcptmisc_cashrcpt_id",                          null: false
    t.integer "cashrcptmisc_accnt_id",                             null: false
    t.decimal "cashrcptmisc_amount",      precision: 20, scale: 2, null: false
    t.text    "cashrcptmisc_notes"
  end

  create_table "ccard", primary_key: "ccard_id", force: :cascade, comment: "Credit Card Information - all bytea data is encrypted" do |t|
    t.integer  "ccard_seq",                                default: 10,                                                  null: false
    t.integer  "ccard_cust_id",                                                                                          null: false
    t.boolean  "ccard_active",                             default: true
    t.binary   "ccard_name"
    t.binary   "ccard_address1"
    t.binary   "ccard_address2"
    t.binary   "ccard_city"
    t.binary   "ccard_state"
    t.binary   "ccard_zip"
    t.binary   "ccard_country"
    t.binary   "ccard_number"
    t.boolean  "ccard_debit",                              default: false
    t.binary   "ccard_month_expired"
    t.binary   "ccard_year_expired"
    t.string   "ccard_type",                     limit: 1,                                                               null: false
    t.datetime "ccard_date_added",                         default: -> { "('now'::text)::timestamp(6) with time zone" }, null: false
    t.datetime "ccard_lastupdated",                        default: -> { "('now'::text)::timestamp(6) with time zone" }, null: false
    t.text     "ccard_added_by_username",                  default: -> { "geteffectivextuser()" },                       null: false
    t.text     "ccard_last_updated_by_username",           default: -> { "geteffectivextuser()" },                       null: false
    t.index ["ccard_cust_id"], name: "ccard_cust_id_idx", using: :btree
  end

  create_table "ccardaud", primary_key: "ccardaud_id", force: :cascade, comment: "Credit Card Information tracking data" do |t|
    t.integer  "ccardaud_ccard_id"
    t.integer  "ccardaud_ccard_seq_old"
    t.integer  "ccardaud_ccard_seq_new"
    t.integer  "ccardaud_ccard_cust_id_old"
    t.integer  "ccardaud_ccard_cust_id_new"
    t.boolean  "ccardaud_ccard_active_old"
    t.boolean  "ccardaud_ccard_active_new"
    t.binary   "ccardaud_ccard_name_old"
    t.binary   "ccardaud_ccard_name_new"
    t.binary   "ccardaud_ccard_address1_old"
    t.binary   "ccardaud_ccard_address1_new"
    t.binary   "ccardaud_ccard_address2_old"
    t.binary   "ccardaud_ccard_address2_new"
    t.binary   "ccardaud_ccard_city_old"
    t.binary   "ccardaud_ccard_city_new"
    t.binary   "ccardaud_ccard_state_old"
    t.binary   "ccardaud_ccard_state_new"
    t.binary   "ccardaud_ccard_zip_old"
    t.binary   "ccardaud_ccard_zip_new"
    t.binary   "ccardaud_ccard_country_old"
    t.binary   "ccardaud_ccard_country_new"
    t.binary   "ccardaud_ccard_number_old"
    t.binary   "ccardaud_ccard_number_new"
    t.boolean  "ccardaud_ccard_debit_old"
    t.boolean  "ccardaud_ccard_debit_new"
    t.binary   "ccardaud_ccard_month_expired_old"
    t.binary   "ccardaud_ccard_month_expired_new"
    t.binary   "ccardaud_ccard_year_expired_old"
    t.binary   "ccardaud_ccard_year_expired_new"
    t.string   "ccardaud_ccard_type_old",                 limit: 1
    t.string   "ccardaud_ccard_type_new",                 limit: 1
    t.datetime "ccardaud_ccard_last_updated",                       default: -> { "('now'::text)::timestamp(6) with time zone" }, null: false
    t.text     "ccardaud_ccard_last_updated_by_username",           default: -> { "geteffectivextuser()" },                       null: false
    t.index ["ccardaud_ccard_cust_id_new"], name: "ccardaud_ccard_cust_id_idx", using: :btree
    t.index ["ccardaud_ccard_id"], name: "ccardaud_ccard_id_idx", using: :btree
  end

  create_table "ccbank", primary_key: "ccbank_id", force: :cascade do |t|
    t.text    "ccbank_ccard_type",   null: false
    t.integer "ccbank_bankaccnt_id"
    t.index ["ccbank_ccard_type"], name: "ccbank_ccbank_ccard_type_key", unique: true, using: :btree
  end

  create_table "ccpay", primary_key: "ccpay_id", force: :cascade, comment: "Track Credit Card PAYments, although really this table tracs communications with Credit Card processing companies. Records in this table may progress from preauthorizations through captures to credits, or they may simply remain in their original state if there is no further processing." do |t|
    t.integer  "ccpay_ccard_id",                                                                                                                           comment: "Internal ID of the Credit Card used for this transaction."
    t.integer  "ccpay_cust_id",                                                                                                                            comment: "Internal ID of the Customer owning the Credit Card"
    t.decimal  "ccpay_amount",                         precision: 20, scale: 2, default: "0.0",                                               null: false, comment: "Actual amount of this transaction."
    t.boolean  "ccpay_auth",                                                    default: true,                                                null: false, comment: "Boolean indicator of whether this transaction started out as a pre-authorization or not."
    t.string   "ccpay_status",               limit: 1,                                                                                        null: false, comment: "The status of the last attempted transaction for this record. Values include A = Authorized, C = Charged, D = Declined or otherwise rejected, V = Voided, X = Error."
    t.string   "ccpay_type",                 limit: 1,                                                                                        null: false, comment: "The most recent type of transaction attempted with this record. Values include A = Authorize, C = Capture or Charge, R = cRedit, V = reVerse or Void."
    t.string   "ccpay_auth_charge",          limit: 1,                                                                                        null: false, comment: "The original type of transaction attempted with this record. Values are the same as for ccpay_type."
    t.text     "ccpay_order_number",                                                                                                                       comment: "The original xTuple ERP order for which this credit card transaction applies. This will usually be either a Sales Order number or Credit Memo number."
    t.integer  "ccpay_order_number_seq",                                                                                                                   comment: "A sequence number to differentiate between different transactions for the same ccpay_order_number. For example, if a Customer makes a down payment and a final payment for a single order, there will be two distinct ccpay records with the same ccpay_order_number but different ccpay_order_number_seq values (1 and 2, respectively)."
    t.text     "ccpay_r_avs",                                                                                                                              comment: "The Address Verification System code returned by the credit card processing company."
    t.text     "ccpay_r_ordernum",                                                                                                                         comment: "A transaction ID returned by the credit card processing company to be used when referring to this transaction later. It may be used for voiding, crediting, or capturing previous transactions."
    t.text     "ccpay_r_error",                                                                                                                            comment: "Error message, if any, describing why this record failed to be processed properly."
    t.text     "ccpay_r_approved",                                                                                                                         comment: "English text stating whether the transaction was approved, declined, hit an error, or was held for review. Specific values differ depending on the credit card processor."
    t.text     "ccpay_r_code",                                                                                                                             comment: "The transaction Approval code returned by the credit card processor. Specific values differ depending on the credit card processor."
    t.text     "ccpay_r_message",                                                                                                                          comment: "Additional text that describes the status of the transaction. This may be empty."
    t.datetime "ccpay_yp_r_time",                                                                                                                          comment: "The time the transaction was posted according to the credit card processing company. May be blank."
    t.text     "ccpay_r_ref",                                                                                                                              comment: "An additional reference number assigned to this transaction by the credit card processing company."
    t.text     "ccpay_yp_r_tdate",                                                                                                                         comment: "The date the transaction was posted according to the credit card processing company. May be blank."
    t.text     "ccpay_r_tax",                                                                                                                              comment: "[ deprecated ]"
    t.text     "ccpay_r_shipping",                                                                                                                         comment: "[ deprecated ]"
    t.integer  "ccpay_yp_r_score",                                                                                                                         comment: "A potential fraud score returned by the credit card company. May be blank."
    t.datetime "ccpay_transaction_datetime",                                    default: -> { "('now'::text)::timestamp(6) with time zone" }, null: false, comment: "The date and time this record was created, unless explicitly set by the application."
    t.text     "ccpay_by_username",                                             default: -> { "geteffectivextuser()" },                       null: false, comment: "The user who created this record, unless explicitly set by the application."
    t.integer  "ccpay_curr_id",                                                 default: -> { "basecurrid()" },                                            comment: "The internal ID of the currency of the ccpay_amount."
    t.integer  "ccpay_ccpay_id",                                                                                                                           comment: "Foreign key to another ccpay record. This will have a value if a new ccpay record is created to record a Refund for part or all of another ccpay record."
    t.text     "ccpay_card_pan_trunc",                                                                                                                     comment: "External Pre-Auth truncated PAN. Last four digits of the card."
    t.text     "ccpay_card_type",                                                                                                                          comment: "External Pre-Auth card type: V=Visa, M=MasterCard, A=American Express, D=Discover."
    t.index ["ccpay_ccard_id"], name: "ccpay_ccard_id_idx", using: :btree
    t.index ["ccpay_cust_id"], name: "ccpay_cust_id_idx", using: :btree
    t.index ["ccpay_order_number"], name: "ccpay_order_number_idx", using: :btree
  end

  create_table "char", primary_key: "char_id", force: :cascade, comment: "Characteristic information" do |t|
    t.text    "char_name",                           null: false
    t.boolean "char_items",                                       comment: "DEPRECATED - this column has been replaced by a row in the charuse table with target_type I"
    t.boolean "char_options"
    t.boolean "char_attributes"
    t.boolean "char_lotserial",                                   comment: "DEPRECATED - this column has been replaced by rows in the charuse table with target_types LS and LSR"
    t.text    "char_notes"
    t.boolean "char_customers",                                   comment: "DEPRECATED - this column has been replaced by rows in the charuse table with target_types C and CT"
    t.boolean "char_crmaccounts",                                 comment: "DEPRECATED - this column has been replaced by a row in the charuse table with target_type CRMA"
    t.boolean "char_addresses",                                   comment: "DEPRECATED - this column has been replaced by a row in the charuse table with target_type ADDR"
    t.boolean "char_contacts",                                    comment: "DEPRECATED - this column has been replaced by a row in the charuse table with target_type CNTCT"
    t.boolean "char_opportunity",                                 comment: "DEPRECATED - this column has been replaced by a row in the charuse table with target_type OPP"
    t.boolean "char_employees",      default: false,              comment: "DEPRECATED - this column has been replaced by a row in the charuse table with target_type EMP"
    t.text    "char_mask"
    t.text    "char_validator"
    t.boolean "char_incidents",      default: false,              comment: "DEPRECATED - this column has been replaced by a row in the charuse table with target_type INCDT"
    t.integer "char_type",           default: 0,     null: false
    t.integer "char_order",          default: 0,     null: false
    t.boolean "char_search",         default: true,  null: false
    t.boolean "char_quotes",         default: false,              comment: "DEPRECATED - this column has been replaced by a row in the charuse table with target_type QU"
    t.boolean "char_salesorders",    default: false,              comment: "DEPRECATED - this column has been replaced by a row in the charuse table with target_type SO"
    t.boolean "char_invoices",       default: false,              comment: "DEPRECATED - this column has been replaced by a row in the charuse table with target_type INV"
    t.boolean "char_vendors",        default: false,              comment: "DEPRECATED - this column has been replaced by a row in the charuse table with target_type V"
    t.boolean "char_purchaseorders", default: false,              comment: "DEPRECATED - this column has been replaced by a row in the charuse table with target_type PO"
    t.boolean "char_vouchers",       default: false,              comment: "DEPRECATED - this column has been replaced by a row in the charuse table with target_type VCH"
    t.boolean "char_projects",       default: false,              comment: "DEPRECATED - this column has been replaced by a row in the charuse table with target_type PROJ"
    t.boolean "char_tasks",          default: false,              comment: "DEPRECATED - this column has been replaced by a row in the charuse table with target_type TASK"
    t.index ["char_name"], name: "char_char_name_key", unique: true, using: :btree
  end

  create_table "charass", primary_key: "charass_id", force: :cascade, comment: "Characteristic assignment information" do |t|
    t.text    "charass_target_type"
    t.integer "charass_target_id"
    t.integer "charass_char_id"
    t.text    "charass_value"
    t.boolean "charass_default",                              default: false, null: false
    t.decimal "charass_price",       precision: 16, scale: 4, default: "0.0", null: false
    t.index ["charass_char_id", "charass_target_type"], name: "charass_char_id_target_type_idx", using: :btree
    t.index ["charass_target_type", "charass_target_id"], name: "charass_target_idx", using: :btree
  end

  create_table "charopt", primary_key: "charopt_id", force: :cascade, comment: "Stores list options for characteristics" do |t|
    t.integer "charopt_char_id",                          comment: "Reference to char table"
    t.text    "charopt_value",               null: false, comment: "Option value"
    t.integer "charopt_order",   default: 0, null: false, comment: "Option sort order"
  end

  create_table "charuse", primary_key: "charuse_id", force: :cascade do |t|
    t.integer  "charuse_char_id"
    t.text     "charuse_target_type",   default: "",             null: false, comment: "If a row exists in the charuse table for a given target type, characteristic assignments can be used"
    t.datetime "charuse_created",       default: -> { "now()" }, null: false
    t.datetime "charuse_last_modified", default: -> { "now()" }, null: false
  end

  create_table "checkhead", primary_key: "checkhead_id", force: :cascade, comment: "Accounts Payable Check Information" do |t|
    t.integer "checkhead_recip_id",                                                               null: false
    t.text    "checkhead_recip_type",                                                             null: false
    t.integer "checkhead_bankaccnt_id",                                                           null: false
    t.boolean "checkhead_printed",                                default: false,                 null: false
    t.date    "checkhead_checkdate",                                                              null: false
    t.integer "checkhead_number",                                                                 null: false
    t.decimal "checkhead_amount",        precision: 20, scale: 2,                                 null: false
    t.boolean "checkhead_void",                                   default: false,                 null: false
    t.boolean "checkhead_replaced",                               default: false,                 null: false
    t.boolean "checkhead_posted",                                 default: false,                 null: false
    t.boolean "checkhead_rec",                                    default: false,                 null: false
    t.boolean "checkhead_misc",                                   default: false,                 null: false
    t.integer "checkhead_expcat_id"
    t.text    "checkhead_for",                                                                    null: false
    t.text    "checkhead_notes",                                                                  null: false
    t.integer "checkhead_journalnumber"
    t.integer "checkhead_curr_id",                                default: -> { "basecurrid()" }, null: false
    t.boolean "checkhead_deleted",                                default: false,                 null: false
    t.text    "checkhead_ach_batch"
    t.decimal "checkhead_curr_rate",                                                              null: false
    t.decimal "checkhead_alt_curr_rate"
    t.index ["checkhead_posted"], name: "checkhead_posted_idx", using: :btree
    t.index ["checkhead_replaced"], name: "checkhead_replaced_idx", using: :btree
  end

  create_table "checkitem", primary_key: "checkitem_id", force: :cascade, comment: "Accounts Payable Check Line Item Information" do |t|
    t.integer "checkitem_checkhead_id",                                                           null: false
    t.decimal "checkitem_amount",        precision: 20, scale: 2, default: "0.0",                 null: false
    t.decimal "checkitem_discount",      precision: 20, scale: 2, default: "0.0",                 null: false
    t.text    "checkitem_ponumber"
    t.text    "checkitem_vouchernumber"
    t.text    "checkitem_invcnumber"
    t.integer "checkitem_apopen_id"
    t.integer "checkitem_aropen_id"
    t.date    "checkitem_docdate"
    t.integer "checkitem_curr_id",                                default: -> { "basecurrid()" }, null: false
    t.text    "checkitem_cmnumber"
    t.text    "checkitem_ranumber"
    t.decimal "checkitem_curr_rate"
    t.index ["checkitem_apopen_id"], name: "checkitem_apopenitem_id_idx", using: :btree
  end

  create_table "classcode", primary_key: "classcode_id", id: :integer, default: -> { "nextval(('classcode_classcode_id_seq'::text)::regclass)" }, force: :cascade, comment: "Class Code information" do |t|
    t.text     "classcode_code",     null: false
    t.text     "classcode_descrip"
    t.boolean  "classcode_mfg"
    t.text     "classcode_creator"
    t.datetime "classcode_created"
    t.text     "classcode_modifier"
    t.datetime "classcode_modified"
    t.text     "classcode_type"
    t.index ["classcode_code"], name: "classcode_classcode_code_key", unique: true, using: :btree
  end

  create_table "cmd", primary_key: "cmd_id", force: :cascade, comment: "Custom menu command table." do |t|
    t.text "cmd_module",     null: false
    t.text "cmd_title",      null: false
    t.text "cmd_descrip"
    t.text "cmd_privname"
    t.text "cmd_executable", null: false
    t.text "cmd_name"
  end

  create_table "cmdarg", primary_key: "cmdarg_id", force: :cascade, comment: "Command argument for custom menu command table." do |t|
    t.integer "cmdarg_cmd_id", null: false
    t.integer "cmdarg_order",  null: false
    t.text    "cmdarg_arg",    null: false
  end

  create_table "cmhead", primary_key: "cmhead_id", id: :integer, default: -> { "nextval(('cmhead_cmhead_id_seq'::text)::regclass)" }, force: :cascade, comment: "S/O Credit Memo header information" do |t|
    t.text    "cmhead_number",                                                                     null: false
    t.boolean "cmhead_posted"
    t.text    "cmhead_invcnumber"
    t.text    "cmhead_custponumber"
    t.integer "cmhead_cust_id"
    t.date    "cmhead_docdate"
    t.integer "cmhead_shipto_id"
    t.text    "cmhead_shipto_name"
    t.text    "cmhead_shipto_address1"
    t.text    "cmhead_shipto_address2"
    t.text    "cmhead_shipto_address3"
    t.text    "cmhead_shipto_city"
    t.text    "cmhead_shipto_state"
    t.text    "cmhead_shipto_zipcode"
    t.integer "cmhead_salesrep_id"
    t.decimal "cmhead_freight",           precision: 16, scale: 4
    t.decimal "cmhead_misc",              precision: 16, scale: 4
    t.text    "cmhead_comments"
    t.boolean "cmhead_printed"
    t.text    "cmhead_billtoname"
    t.text    "cmhead_billtoaddress1"
    t.text    "cmhead_billtoaddress2"
    t.text    "cmhead_billtoaddress3"
    t.text    "cmhead_billtocity"
    t.text    "cmhead_billtostate"
    t.text    "cmhead_billtozip"
    t.boolean "cmhead_hold"
    t.decimal "cmhead_commission",        precision: 8,  scale: 4
    t.integer "cmhead_misc_accnt_id"
    t.text    "cmhead_misc_descrip"
    t.integer "cmhead_rsncode_id"
    t.integer "cmhead_curr_id",                                    default: -> { "basecurrid()" }
    t.integer "cmhead_freighttaxtype_id",                                                                       comment: "Deprecated column - DO NOT USE"
    t.date    "cmhead_gldistdate"
    t.text    "cmhead_billtocountry"
    t.text    "cmhead_shipto_country"
    t.integer "cmhead_rahead_id"
    t.integer "cmhead_taxzone_id"
    t.integer "cmhead_prj_id"
    t.boolean "cmhead_void",                                       default: false
    t.integer "cmhead_saletype_id",                                                                             comment: "Associated sale type for credit memo."
    t.integer "cmhead_shipzone_id",                                                                             comment: "Associated shipping zone for credit memo."
    t.index ["cmhead_invcnumber"], name: "cmhead_invcnumber_idx", using: :btree
    t.index ["cmhead_number"], name: "cmhead_cmhead_number_key", unique: true, using: :btree
  end

  create_table "cmheadtax", primary_key: "taxhist_id", id: :integer, default: -> { "nextval('taxhist_taxhist_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "taxhist_parent_id",                              null: false
    t.integer "taxhist_taxtype_id"
    t.integer "taxhist_tax_id",                                 null: false
    t.decimal "taxhist_basis",         precision: 16, scale: 2, null: false
    t.integer "taxhist_basis_tax_id"
    t.integer "taxhist_sequence"
    t.decimal "taxhist_percent",       precision: 10, scale: 6, null: false
    t.decimal "taxhist_amount",        precision: 16, scale: 2, null: false
    t.decimal "taxhist_tax",           precision: 16, scale: 6, null: false
    t.date    "taxhist_docdate",                                null: false
    t.date    "taxhist_distdate"
    t.integer "taxhist_curr_id"
    t.decimal "taxhist_curr_rate"
    t.integer "taxhist_journalnumber"
    t.index ["taxhist_parent_id", "taxhist_taxtype_id"], name: "cmheadtax_taxhist_parent_type_idx", using: :btree
    t.index ["taxhist_parent_id"], name: "cmheadtax_taxhist_parent_id_idx", using: :btree
    t.index ["taxhist_taxtype_id"], name: "cmheadtax_taxhist_taxtype_id_idx", using: :btree
  end

  create_table "cmitem", primary_key: "cmitem_id", id: :integer, default: -> { "nextval(('cmitem_cmitem_id_seq'::text)::regclass)" }, force: :cascade, comment: "S/O Credit Memo Line Item information" do |t|
    t.integer "cmitem_cmhead_id",                                                  null: false
    t.integer "cmitem_linenumber",                                                 null: false
    t.integer "cmitem_itemsite_id",                                                null: false
    t.decimal "cmitem_qtycredit",         precision: 18, scale: 6,                 null: false
    t.decimal "cmitem_qtyreturned",       precision: 18, scale: 6,                 null: false
    t.decimal "cmitem_unitprice",         precision: 16, scale: 4,                 null: false
    t.text    "cmitem_comments"
    t.integer "cmitem_rsncode_id"
    t.integer "cmitem_taxtype_id"
    t.integer "cmitem_qty_uom_id",                                                 null: false
    t.decimal "cmitem_qty_invuomratio",   precision: 20, scale: 10,                null: false
    t.integer "cmitem_price_uom_id",                                               null: false
    t.decimal "cmitem_price_invuomratio", precision: 20, scale: 10,                null: false
    t.integer "cmitem_raitem_id"
    t.boolean "cmitem_updateinv",                                   default: true, null: false
    t.index ["cmitem_cmhead_id", "cmitem_linenumber"], name: "cmitem_cmhead_id_linenumber_unique", unique: true, using: :btree
  end

  create_table "cmitemtax", primary_key: "taxhist_id", id: :integer, default: -> { "nextval('taxhist_taxhist_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "taxhist_parent_id",                              null: false
    t.integer "taxhist_taxtype_id"
    t.integer "taxhist_tax_id",                                 null: false
    t.decimal "taxhist_basis",         precision: 16, scale: 2, null: false
    t.integer "taxhist_basis_tax_id"
    t.integer "taxhist_sequence"
    t.decimal "taxhist_percent",       precision: 10, scale: 6, null: false
    t.decimal "taxhist_amount",        precision: 16, scale: 2, null: false
    t.decimal "taxhist_tax",           precision: 16, scale: 6, null: false
    t.date    "taxhist_docdate",                                null: false
    t.date    "taxhist_distdate"
    t.integer "taxhist_curr_id"
    t.decimal "taxhist_curr_rate"
    t.integer "taxhist_journalnumber"
    t.index ["taxhist_parent_id", "taxhist_taxtype_id"], name: "cmitemtax_taxhist_parent_type_idx", using: :btree
    t.index ["taxhist_parent_id"], name: "cmitemtax_taxhist_parent_id_idx", using: :btree
    t.index ["taxhist_taxtype_id"], name: "cmitemtax_taxhist_taxtype_id_idx", using: :btree
  end

  create_table "cmnttype", primary_key: "cmnttype_id", force: :cascade, comment: "Comment Type information" do |t|
    t.text    "cmnttype_name",                     null: false
    t.text    "cmnttype_descrip",                  null: false
    t.text    "cmnttype_usedin"
    t.boolean "cmnttype_sys",      default: false, null: false
    t.boolean "cmnttype_editable", default: false, null: false
    t.integer "cmnttype_order"
    t.index ["cmnttype_name"], name: "cmnttype_cmnttype_name_key", unique: true, using: :btree
  end

  create_table "cmnttypesource", primary_key: "cmnttypesource_id", force: :cascade, comment: "Description of which types of comment the user should be allowed to select for various types of document (source)." do |t|
    t.integer "cmnttypesource_cmnttype_id", null: false
    t.integer "cmnttypesource_source_id",   null: false
  end

  create_table "cntct", primary_key: "cntct_id", force: :cascade, comment: "Contact - information on how to reach a living person" do |t|
    t.integer "cntct_crmacct_id"
    t.integer "cntct_addr_id"
    t.text    "cntct_first_name"
    t.text    "cntct_last_name"
    t.text    "cntct_honorific"
    t.text    "cntct_initials"
    t.boolean "cntct_active",         default: true
    t.text    "cntct_phone"
    t.text    "cntct_phone2"
    t.text    "cntct_fax"
    t.text    "cntct_email"
    t.text    "cntct_webaddr"
    t.text    "cntct_notes"
    t.text    "cntct_title"
    t.text    "cntct_number",                        null: false
    t.text    "cntct_middle"
    t.text    "cntct_suffix"
    t.text    "cntct_owner_username"
    t.text    "cntct_name"
    t.index ["cntct_email"], name: "cntct_email_idx", using: :btree
    t.index ["cntct_name"], name: "cntct_name_idx", using: :btree
    t.index ["cntct_number"], name: "cntct_cntct_number_key", unique: true, using: :btree
  end

  create_table "cntctaddr", primary_key: "cntctaddr_id", force: :cascade do |t|
    t.integer "cntctaddr_cntct_id"
    t.boolean "cntctaddr_primary",            null: false
    t.integer "cntctaddr_addr_id",            null: false
    t.string  "cntctaddr_type",     limit: 2, null: false
  end

  create_table "cntctdata", primary_key: "cntctdata_id", force: :cascade do |t|
    t.integer "cntctdata_cntct_id"
    t.boolean "cntctdata_primary",            null: false
    t.text    "cntctdata_text",               null: false
    t.string  "cntctdata_type",     limit: 2, null: false
  end

  create_table "cntcteml", primary_key: "cntcteml_id", force: :cascade, comment: "Stores email addresses for contacts" do |t|
    t.integer "cntcteml_cntct_id",                              comment: "Reference to contact table"
    t.boolean "cntcteml_primary",  default: false, null: false, comment: "Flags whether this is the primary email address"
    t.text    "cntcteml_email",                    null: false, comment: "Alternate information"
  end

  create_table "cntctmrgd", primary_key: "cntctmrgd_cntct_id", id: :integer, force: :cascade do |t|
    t.boolean "cntctmrgd_error", default: false
  end

  create_table "cntctsel", primary_key: "cntctsel_cntct_id", id: :integer, force: :cascade do |t|
    t.boolean "cntctsel_target"
    t.boolean "cntctsel_mrg_crmacct_id",     default: false
    t.boolean "cntctsel_mrg_addr_id",        default: false
    t.boolean "cntctsel_mrg_first_name",     default: false
    t.boolean "cntctsel_mrg_last_name",      default: false
    t.boolean "cntctsel_mrg_honorific",      default: false
    t.boolean "cntctsel_mrg_initials",       default: false
    t.boolean "cntctsel_mrg_phone",          default: false
    t.boolean "cntctsel_mrg_phone2",         default: false
    t.boolean "cntctsel_mrg_fax",            default: false
    t.boolean "cntctsel_mrg_email",          default: false
    t.boolean "cntctsel_mrg_webaddr",        default: false
    t.boolean "cntctsel_mrg_notes",          default: false
    t.boolean "cntctsel_mrg_title",          default: false
    t.boolean "cntctsel_mrg_middle",         default: false
    t.boolean "cntctsel_mrg_suffix",         default: false
    t.boolean "cntctsel_mrg_owner_username", default: false
  end

  create_table "cntslip", primary_key: "cntslip_id", id: :integer, default: -> { "nextval(('\"cntslip_cntslip_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Count Slip information" do |t|
    t.integer  "cntslip_cnttag_id"
    t.datetime "cntslip_entered"
    t.boolean  "cntslip_posted"
    t.text     "cntslip_number"
    t.decimal  "cntslip_qty",                  precision: 18, scale: 6
    t.text     "cntslip_comments"
    t.integer  "cntslip_location_id"
    t.text     "cntslip_lotserial"
    t.date     "cntslip_lotserial_expiration"
    t.date     "cntslip_lotserial_warrpurc"
    t.text     "cntslip_username"
  end

  create_table "cobill", primary_key: "cobill_id", id: :integer, default: -> { "nextval(('cobill_cobill_id_seq'::text)::regclass)" }, force: :cascade, comment: "Billing Selection Line Item information" do |t|
    t.integer  "cobill_coitem_id"
    t.datetime "cobill_selectdate"
    t.decimal  "cobill_qty",             precision: 18, scale: 6
    t.integer  "cobill_invcnum"
    t.boolean  "cobill_toclose"
    t.integer  "cobill_cobmisc_id"
    t.text     "cobill_select_username"
    t.integer  "cobill_invcitem_id"
    t.integer  "cobill_taxtype_id"
    t.index ["cobill_cobmisc_id"], name: "cobill_cobmisc_id", using: :btree
    t.index ["cobill_coitem_id"], name: "cobill_coitem_id", using: :btree
  end

  create_table "cobilltax", primary_key: "taxhist_id", id: :integer, default: -> { "nextval('taxhist_taxhist_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "taxhist_parent_id",                              null: false
    t.integer "taxhist_taxtype_id"
    t.integer "taxhist_tax_id",                                 null: false
    t.decimal "taxhist_basis",         precision: 16, scale: 2, null: false
    t.integer "taxhist_basis_tax_id"
    t.integer "taxhist_sequence"
    t.decimal "taxhist_percent",       precision: 10, scale: 6, null: false
    t.decimal "taxhist_amount",        precision: 16, scale: 2, null: false
    t.decimal "taxhist_tax",           precision: 16, scale: 6, null: false
    t.date    "taxhist_docdate",                                null: false
    t.date    "taxhist_distdate"
    t.integer "taxhist_curr_id"
    t.decimal "taxhist_curr_rate"
    t.integer "taxhist_journalnumber"
    t.index ["taxhist_parent_id", "taxhist_taxtype_id"], name: "cobilltax_taxhist_parent_type_idx", using: :btree
    t.index ["taxhist_parent_id"], name: "cobilltax_taxhist_parent_id_idx", using: :btree
    t.index ["taxhist_taxtype_id"], name: "cobilltax_taxhist_taxtype_id_idx", using: :btree
  end

  create_table "cobmisc", primary_key: "cobmisc_id", id: :integer, default: -> { "nextval(('cobmisc_cobmisc_id_seq'::text)::regclass)" }, force: :cascade, comment: "General information about Billing Selections" do |t|
    t.integer "cobmisc_cohead_id"
    t.text    "cobmisc_shipvia"
    t.decimal "cobmisc_freight",       precision: 16, scale: 4
    t.decimal "cobmisc_misc",          precision: 16, scale: 4
    t.decimal "cobmisc_payment",       precision: 16, scale: 4
    t.text    "cobmisc_paymentref"
    t.text    "cobmisc_notes"
    t.date    "cobmisc_shipdate"
    t.integer "cobmisc_invcnumber"
    t.date    "cobmisc_invcdate"
    t.boolean "cobmisc_posted"
    t.integer "cobmisc_misc_accnt_id"
    t.text    "cobmisc_misc_descrip"
    t.boolean "cobmisc_closeorder"
    t.integer "cobmisc_curr_id",                                default: -> { "basecurrid()" }
    t.integer "cobmisc_invchead_id"
    t.integer "cobmisc_taxzone_id"
    t.integer "cobmisc_taxtype_id"
    t.index ["cobmisc_cohead_id"], name: "cobmisc_cohead_id", using: :btree
    t.index ["cobmisc_posted"], name: "cobmisc_posted", using: :btree
  end

  create_table "cobmisctax", primary_key: "taxhist_id", id: :integer, default: -> { "nextval('taxhist_taxhist_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "taxhist_parent_id",                              null: false
    t.integer "taxhist_taxtype_id"
    t.integer "taxhist_tax_id",                                 null: false
    t.decimal "taxhist_basis",         precision: 16, scale: 2, null: false
    t.integer "taxhist_basis_tax_id"
    t.integer "taxhist_sequence"
    t.decimal "taxhist_percent",       precision: 10, scale: 6, null: false
    t.decimal "taxhist_amount",        precision: 16, scale: 2, null: false
    t.decimal "taxhist_tax",           precision: 16, scale: 6, null: false
    t.date    "taxhist_docdate",                                null: false
    t.date    "taxhist_distdate"
    t.integer "taxhist_curr_id"
    t.decimal "taxhist_curr_rate"
    t.integer "taxhist_journalnumber"
    t.index ["taxhist_parent_id", "taxhist_taxtype_id"], name: "cobmisctax_taxhist_parent_type_idx", using: :btree
    t.index ["taxhist_parent_id"], name: "cobmisctax_taxhist_parent_id_idx", using: :btree
    t.index ["taxhist_taxtype_id"], name: "cobmisctax_taxhist_taxtype_id_idx", using: :btree
  end

  create_table "cohead", primary_key: "cohead_id", id: :integer, default: -> { "nextval(('cohead_cohead_id_seq'::text)::regclass)" }, force: :cascade, comment: "Sales Order header information" do |t|
    t.text     "cohead_number",                                                                                                                   null: false
    t.integer  "cohead_cust_id",                                                                                                                  null: false
    t.text     "cohead_custponumber"
    t.string   "cohead_type",                    limit: 1
    t.date     "cohead_orderdate"
    t.integer  "cohead_warehous_id"
    t.integer  "cohead_shipto_id"
    t.text     "cohead_shiptoname"
    t.text     "cohead_shiptoaddress1"
    t.text     "cohead_shiptoaddress2"
    t.text     "cohead_shiptoaddress3"
    t.text     "cohead_shiptoaddress4"
    t.text     "cohead_shiptoaddress5"
    t.integer  "cohead_salesrep_id",                                                                                                              null: false
    t.integer  "cohead_terms_id",                                                                                                                 null: false
    t.string   "cohead_origin",                  limit: 1
    t.text     "cohead_fob"
    t.text     "cohead_shipvia"
    t.text     "cohead_shiptocity"
    t.text     "cohead_shiptostate"
    t.text     "cohead_shiptozipcode"
    t.decimal  "cohead_freight",                           precision: 16, scale: 4,                                                               null: false
    t.decimal  "cohead_misc",                              precision: 16, scale: 4, default: "0.0",                                               null: false
    t.boolean  "cohead_imported",                                                   default: false
    t.text     "cohead_ordercomments"
    t.text     "cohead_shipcomments"
    t.text     "cohead_shiptophone"
    t.integer  "cohead_shipchrg_id"
    t.integer  "cohead_shipform_id"
    t.text     "cohead_billtoname"
    t.text     "cohead_billtoaddress1"
    t.text     "cohead_billtoaddress2"
    t.text     "cohead_billtoaddress3"
    t.text     "cohead_billtocity"
    t.text     "cohead_billtostate"
    t.text     "cohead_billtozipcode"
    t.integer  "cohead_misc_accnt_id"
    t.text     "cohead_misc_descrip"
    t.decimal  "cohead_commission",                        precision: 16, scale: 4
    t.date     "cohead_miscdate"
    t.string   "cohead_holdtype",                limit: 1
    t.date     "cohead_packdate"
    t.integer  "cohead_prj_id"
    t.boolean  "cohead_wasquote",                                                   default: false,                                               null: false
    t.datetime "cohead_lastupdated",                                                default: -> { "('now'::text)::timestamp(6) with time zone" }, null: false
    t.boolean  "cohead_shipcomplete",                                               default: false,                                               null: false
    t.datetime "cohead_created",                                                    default: -> { "('now'::text)::timestamp(6) with time zone" }
    t.text     "cohead_creator",                                                    default: -> { "geteffectivextuser()" }
    t.text     "cohead_quote_number"
    t.text     "cohead_billtocountry"
    t.text     "cohead_shiptocountry"
    t.integer  "cohead_curr_id",                                                    default: -> { "basecurrid()" }
    t.boolean  "cohead_calcfreight",                                                default: false,                                               null: false
    t.integer  "cohead_shipto_cntct_id"
    t.text     "cohead_shipto_cntct_honorific"
    t.text     "cohead_shipto_cntct_first_name"
    t.text     "cohead_shipto_cntct_middle"
    t.text     "cohead_shipto_cntct_last_name"
    t.text     "cohead_shipto_cntct_suffix"
    t.text     "cohead_shipto_cntct_phone"
    t.text     "cohead_shipto_cntct_title"
    t.text     "cohead_shipto_cntct_fax"
    t.text     "cohead_shipto_cntct_email"
    t.integer  "cohead_billto_cntct_id"
    t.text     "cohead_billto_cntct_honorific"
    t.text     "cohead_billto_cntct_first_name"
    t.text     "cohead_billto_cntct_middle"
    t.text     "cohead_billto_cntct_last_name"
    t.text     "cohead_billto_cntct_suffix"
    t.text     "cohead_billto_cntct_phone"
    t.text     "cohead_billto_cntct_title"
    t.text     "cohead_billto_cntct_fax"
    t.text     "cohead_billto_cntct_email"
    t.integer  "cohead_taxzone_id"
    t.integer  "cohead_taxtype_id"
    t.integer  "cohead_ophead_id"
    t.string   "cohead_status",                  limit: 1,                          default: "O",                                                 null: false
    t.integer  "cohead_saletype_id",                                                                                                                           comment: "Associated sale type for sales order."
    t.integer  "cohead_shipzone_id",                                                                                                                           comment: "Associated shipping zone for sales order."
    t.index ["cohead_cust_id"], name: "cohead_cust_id_key", using: :btree
    t.index ["cohead_custponumber"], name: "cohead_custponumber_idx", using: :btree
    t.index ["cohead_number"], name: "cohead_cohead_number_key", unique: true, using: :btree
    t.index ["cohead_number"], name: "cohead_number_idx", unique: true, using: :btree
    t.index ["cohead_shipto_id"], name: "cohead_shipto_id", using: :btree
    t.index ["cohead_status"], name: "cohead_cohead_status_idx", using: :btree
  end

  create_table "cohist", primary_key: "cohist_id", id: :integer, default: -> { "nextval(('cohist_cohist_id_seq'::text)::regclass)" }, force: :cascade, comment: "Sales Order history" do |t|
    t.integer "cohist_cust_id"
    t.integer "cohist_itemsite_id"
    t.date    "cohist_shipdate"
    t.text    "cohist_shipvia"
    t.text    "cohist_ordernumber"
    t.date    "cohist_orderdate"
    t.text    "cohist_invcnumber"
    t.date    "cohist_invcdate"
    t.decimal "cohist_qtyshipped",                precision: 18, scale: 6
    t.decimal "cohist_unitprice",                 precision: 16, scale: 4
    t.integer "cohist_shipto_id"
    t.integer "cohist_salesrep_id"
    t.date    "cohist_duedate"
    t.boolean "cohist_imported",                                           default: false
    t.text    "cohist_billtoname"
    t.text    "cohist_billtoaddress1"
    t.text    "cohist_billtoaddress2"
    t.text    "cohist_billtoaddress3"
    t.text    "cohist_billtocity"
    t.text    "cohist_billtostate"
    t.text    "cohist_billtozip"
    t.text    "cohist_shiptoname"
    t.text    "cohist_shiptoaddress1"
    t.text    "cohist_shiptoaddress2"
    t.text    "cohist_shiptoaddress3"
    t.text    "cohist_shiptocity"
    t.text    "cohist_shiptostate"
    t.text    "cohist_shiptozip"
    t.decimal "cohist_commission",                precision: 16, scale: 4
    t.boolean "cohist_commissionpaid"
    t.decimal "cohist_unitcost",                  precision: 18, scale: 6
    t.string  "cohist_misc_type",       limit: 1
    t.text    "cohist_misc_descrip"
    t.integer "cohist_misc_id"
    t.text    "cohist_doctype"
    t.date    "cohist_promisedate"
    t.text    "cohist_ponumber"
    t.integer "cohist_curr_id",                                            default: -> { "basecurrid()" }
    t.integer "cohist_sequence"
    t.integer "cohist_taxtype_id"
    t.integer "cohist_taxzone_id"
    t.integer "cohist_saletype_id",                                                                        comment: "Associated sale type for sales history."
    t.integer "cohist_shipzone_id",                                                                        comment: "Associated shipping zone for sales history."
    t.integer "cohist_cohead_ccpay_id",                                                                    comment: "Credit card payments made at sales order time (as opposed to invoice time) need special treatment. This field allows checking for this case."
    t.index ["cohist_cust_id"], name: "cohist_cust_id", using: :btree
    t.index ["cohist_invcnumber"], name: "cohist_invcnumber", using: :btree
    t.index ["cohist_itemsite_id"], name: "cohist_itemsite_id", using: :btree
    t.index ["cohist_shipdate"], name: "cohist_shipdate", using: :btree
    t.index ["cohist_shipto_id"], name: "cohist_shipto_id", using: :btree
  end

  create_table "cohisttax", primary_key: "taxhist_id", id: :integer, default: -> { "nextval('taxhist_taxhist_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "taxhist_parent_id",                              null: false
    t.integer "taxhist_taxtype_id"
    t.integer "taxhist_tax_id",                                 null: false
    t.decimal "taxhist_basis",         precision: 16, scale: 2, null: false
    t.integer "taxhist_basis_tax_id"
    t.integer "taxhist_sequence"
    t.decimal "taxhist_percent",       precision: 10, scale: 6, null: false
    t.decimal "taxhist_amount",        precision: 16, scale: 2, null: false
    t.decimal "taxhist_tax",           precision: 16, scale: 6, null: false
    t.date    "taxhist_docdate",                                null: false
    t.date    "taxhist_distdate"
    t.integer "taxhist_curr_id"
    t.decimal "taxhist_curr_rate"
    t.integer "taxhist_journalnumber"
    t.index ["taxhist_parent_id", "taxhist_taxtype_id"], name: "cohisttax_taxhist_parent_type_idx", using: :btree
    t.index ["taxhist_parent_id"], name: "cohisttax_taxhist_parent_id_idx", using: :btree
    t.index ["taxhist_taxtype_id"], name: "cohisttax_taxhist_taxtype_id_idx", using: :btree
  end

  create_table "coitem", primary_key: "coitem_id", id: :integer, default: -> { "nextval(('coitem_coitem_id_seq'::text)::regclass)" }, force: :cascade, comment: "Sales Order Line Item information" do |t|
    t.integer  "coitem_cohead_id"
    t.integer  "coitem_linenumber",                                                                                                           null: false
    t.integer  "coitem_itemsite_id"
    t.string   "coitem_status",             limit: 1
    t.date     "coitem_scheddate"
    t.date     "coitem_promdate"
    t.decimal  "coitem_qtyord",                       precision: 18, scale: 6,                                                                null: false
    t.decimal  "coitem_unitcost",                     precision: 16, scale: 6,                                                                null: false
    t.decimal  "coitem_price",                        precision: 16, scale: 4,                                                                null: false
    t.decimal  "coitem_custprice",                    precision: 16, scale: 4,                                                                null: false
    t.decimal  "coitem_qtyshipped",                   precision: 18, scale: 6,                                                                null: false
    t.integer  "coitem_order_id"
    t.text     "coitem_memo"
    t.boolean  "coitem_imported",                                               default: false
    t.decimal  "coitem_qtyreturned",                  precision: 18, scale: 6
    t.datetime "coitem_closedate"
    t.text     "coitem_custpn"
    t.string   "coitem_order_type",         limit: 1
    t.text     "coitem_close_username"
    t.datetime "coitem_lastupdated",                                            default: -> { "('now'::text)::timestamp(6) with time zone" }, null: false
    t.integer  "coitem_substitute_item_id"
    t.datetime "coitem_created",                                                default: -> { "('now'::text)::timestamp(6) with time zone" }
    t.text     "coitem_creator",                                                default: -> { "geteffectivextuser()" }
    t.decimal  "coitem_prcost",                       precision: 16, scale: 6
    t.integer  "coitem_qty_uom_id",                                                                                                           null: false
    t.decimal  "coitem_qty_invuomratio",              precision: 20, scale: 10,                                                               null: false
    t.integer  "coitem_price_uom_id",                                                                                                         null: false
    t.decimal  "coitem_price_invuomratio",            precision: 20, scale: 10,                                                               null: false
    t.boolean  "coitem_warranty",                                               default: false,                                               null: false
    t.integer  "coitem_cos_accnt_id"
    t.decimal  "coitem_qtyreserved",                  precision: 18, scale: 6,  default: "0.0",                                               null: false
    t.integer  "coitem_subnumber",                                              default: 0,                                                   null: false
    t.boolean  "coitem_firm",                                                   default: false,                                               null: false
    t.integer  "coitem_taxtype_id"
    t.string   "coitem_pricemode",          limit: 1,                           default: "D",                                                 null: false, comment: "Pricing mode for sales order item.  Valid values are D-discount, and M-markup"
    t.integer  "coitem_rev_accnt_id"
    t.integer  "coitem_qtyreserved_uom_id",                                                                                                                comment: "UOM of qtyreserved (same as Item Inv UOM)."
    t.index ["coitem_cohead_id", "coitem_linenumber", "coitem_subnumber"], name: "coitem_coitem_cohead_id_key", unique: true, using: :btree
    t.index ["coitem_cohead_id"], name: "coitem_cohead_id_key", using: :btree
    t.index ["coitem_itemsite_id"], name: "coitem_itemsite_id", using: :btree
    t.index ["coitem_linenumber"], name: "coitem_linenumber_key", using: :btree
    t.index ["coitem_status"], name: "coitem_status_key", using: :btree
  end

  create_table "comment", primary_key: "comment_id", id: :integer, default: -> { "nextval(('\"comment_comment_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Comment information" do |t|
    t.integer  "comment_source_id"
    t.datetime "comment_date"
    t.text     "comment_user"
    t.text     "comment_text"
    t.integer  "comment_cmnttype_id"
    t.text     "comment_source"
    t.boolean  "comment_public"
    t.index ["comment_source", "comment_source_id"], name: "comment_comment_source_idx", using: :btree
  end

  create_table "company", primary_key: "company_id", force: :cascade, comment: "Company information" do |t|
    t.text    "company_number",                                 null: false
    t.text    "company_descrip"
    t.boolean "company_external",               default: false, null: false
    t.text    "company_server"
    t.integer "company_port"
    t.text    "company_database"
    t.integer "company_curr_id"
    t.integer "company_yearend_accnt_id"
    t.integer "company_gainloss_accnt_id"
    t.integer "company_dscrp_accnt_id"
    t.integer "company_unrlzgainloss_accnt_id"
    t.integer "company_unassigned_accnt_id"
    t.index ["company_number"], name: "company_company_number_key", unique: true, using: :btree
  end

  create_table "contrct", primary_key: "contrct_id", force: :cascade, comment: "Grouping of Item Sources for a Vendor with common effective and expiration dates." do |t|
    t.text    "contrct_number",    null: false, comment: "User defined identifier for contract."
    t.integer "contrct_vend_id",   null: false, comment: "Vendor associated with contract."
    t.text    "contrct_descrip",                comment: "Description for contract."
    t.date    "contrct_effective", null: false, comment: "Effective date for contract.  Constraint for overlap."
    t.date    "contrct_expires",   null: false, comment: "Expiration date for contract.  Constraint for overlap."
    t.text    "contrct_note",                   comment: "Notes for contract."
    t.index ["contrct_number", "contrct_vend_id"], name: "contrct_master_idx", unique: true, using: :btree
  end

  create_table "costcat", primary_key: "costcat_id", id: :integer, default: -> { "nextval(('costcat_costcat_id_seq'::text)::regclass)" }, force: :cascade, comment: "Cost Category information" do |t|
    t.text    "costcat_code",                   null: false
    t.text    "costcat_descrip"
    t.integer "costcat_asset_accnt_id"
    t.integer "costcat_liability_accnt_id"
    t.integer "costcat_adjustment_accnt_id"
    t.integer "costcat_matusage_accnt_id"
    t.integer "costcat_purchprice_accnt_id"
    t.integer "costcat_laboroverhead_accnt_id"
    t.integer "costcat_scrap_accnt_id"
    t.integer "costcat_invcost_accnt_id"
    t.integer "costcat_wip_accnt_id"
    t.integer "costcat_shipasset_accnt_id"
    t.integer "costcat_mfgscrap_accnt_id"
    t.integer "costcat_transform_accnt_id"
    t.integer "costcat_freight_accnt_id"
    t.integer "costcat_toliability_accnt_id"
    t.integer "costcat_exp_accnt_id"
    t.index ["costcat_code"], name: "costcat_costcat_code_key", unique: true, using: :btree
  end

  create_table "costelem", primary_key: "costelem_id", id: :integer, default: -> { "nextval(('costelem_costelem_id_seq'::text)::regclass)" }, force: :cascade, comment: "Costing Element information" do |t|
    t.text    "costelem_type",         null: false
    t.boolean "costelem_sys"
    t.boolean "costelem_po"
    t.boolean "costelem_active"
    t.integer "costelem_exp_accnt_id"
    t.integer "costelem_cost_item_id"
    t.index ["costelem_type"], name: "costelem_costelem_type_key", unique: true, using: :btree
  end

  create_table "costhist", primary_key: "costhist_id", id: :integer, default: -> { "nextval(('\"costhist_costhist_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Item Cost history" do |t|
    t.integer  "costhist_item_id"
    t.integer  "costhist_costelem_id"
    t.string   "costhist_type",        limit: 1
    t.datetime "costhist_date"
    t.decimal  "costhist_oldcost",               precision: 16, scale: 6
    t.decimal  "costhist_newcost",               precision: 16, scale: 6
    t.boolean  "costhist_lowlevel"
    t.integer  "costhist_oldcurr_id",                                     default: -> { "basecurrid()" }
    t.integer  "costhist_newcurr_id",                                     default: -> { "basecurrid()" }
    t.text     "costhist_username"
  end

  create_table "costupdate", id: false, force: :cascade, comment: "Scratch area for sequencing the updating of item costs" do |t|
    t.integer "costupdate_item_id"
    t.integer "costupdate_lowlevel_code",           default: 1, null: false
    t.string  "costupdate_item_type",     limit: 1
    t.index ["costupdate_item_id"], name: "costupdate_costupdate_item_id_key", unique: true, using: :btree
  end

  create_table "country", primary_key: "country_id", force: :cascade, comment: "Basic information and properties about countries." do |t|
    t.string  "country_abbr",        limit: 2
    t.text    "country_name"
    t.string  "country_curr_abbr",   limit: 3
    t.text    "country_curr_name"
    t.string  "country_curr_number", limit: 3
    t.string  "country_curr_symbol", limit: 9
    t.integer "country_qt_number"
    t.index ["country_abbr"], name: "country_country_abbr_key", unique: true, using: :btree
    t.index ["country_name"], name: "country_country_name_key", unique: true, using: :btree
  end

  create_table "crmacct", primary_key: "crmacct_id", force: :cascade, comment: "CRM Accounts are umbrella records that tie together people and organizations with whom we have business relationships." do |t|
    t.text    "crmacct_number",                                  null: false, comment: "Abbreviated human-readable identifier for this CRM Account."
    t.text    "crmacct_name",                                                 comment: "Long name of this CRM Account."
    t.boolean "crmacct_active",                   default: true,              comment: "This CRM Account is available for new activity."
    t.string  "crmacct_type",           limit: 1,                             comment: "This indicates whether the CRM Account represents an organization or an individual person."
    t.integer "crmacct_cust_id",                                              comment: "If this is not null, this CRM Account is a Customer."
    t.integer "crmacct_competitor_id",                                        comment: "For now, > 0 indicates this CRM Account is a competitor. Eventually this may become a foreign key to a table of competitors."
    t.integer "crmacct_partner_id",                                           comment: "For now, > 0 indicates this CRM Account is a partner. Eventually this may become a foreign key to a table of partners."
    t.integer "crmacct_prospect_id",                                          comment: "If this is not null, this CRM Account is a Prospect."
    t.integer "crmacct_vend_id",                                              comment: "If this is not null, this CRM Account is a Vendor."
    t.integer "crmacct_cntct_id_1",                                           comment: "The primary contact for the CRM Account."
    t.integer "crmacct_cntct_id_2",                                           comment: "The secondary contact for the CRM Account."
    t.integer "crmacct_parent_id",                                            comment: "The internal ID of an (optional) parent CRM Account. For example, if the current CRM Account is a subsidiary of another company, the crmacct_parent_id points to the CRM Account representing that parent company."
    t.text    "crmacct_notes",                                                comment: "Free-form comments pertaining to the CRM Account."
    t.integer "crmacct_taxauth_id",                                           comment: "If this is not null, this CRM Account is a Tax Authority."
    t.text    "crmacct_owner_username",                                       comment: "The application User responsible for this CRM Account."
    t.integer "crmacct_emp_id",                                               comment: "If this is not null, this CRM Account is an Employee."
    t.integer "crmacct_salesrep_id",                                          comment: "If this is not null, this CRM Account is a Sales Rep."
    t.text    "crmacct_usr_username",                                         comment: "If this is not null, this CRM Account is an application User."
    t.index ["crmacct_number"], name: "crmacct_crmacct_number_key", unique: true, using: :btree
  end

  create_table "crmacctsel", primary_key: "crmacctsel_src_crmacct_id", id: :integer, comment: "This is the internal ID of the CRM Account record the data will come from during the merge.", force: :cascade, comment: "This table records the proposed conditions of a CRM Account merge. When this merge is performed, the BOOLEAN columns in this table indicate which values in the crmacct table will be copied to the target record. Data in this table are temporary and will be removed by a purge." do |t|
    t.integer "crmacctsel_dest_crmacct_id",                                         comment: "This is the internal ID of the CRM Account record the data will go to during the merge. If crmacctsel_src_crmacct_id = crmacctsel_dest_crmacct_id, they indicate which crmacct record is the destination of the merge, meaning this is the record that will remain in the database after the merge has been completed and the intermediate data have been purged."
    t.boolean "crmacctsel_mrg_crmacct_active",         default: false, null: false
    t.boolean "crmacctsel_mrg_crmacct_cntct_id_1",     default: false, null: false
    t.boolean "crmacctsel_mrg_crmacct_cntct_id_2",     default: false, null: false
    t.boolean "crmacctsel_mrg_crmacct_competitor_id",  default: false, null: false
    t.boolean "crmacctsel_mrg_crmacct_cust_id",        default: false, null: false
    t.boolean "crmacctsel_mrg_crmacct_emp_id",         default: false, null: false
    t.boolean "crmacctsel_mrg_crmacct_name",           default: false, null: false
    t.boolean "crmacctsel_mrg_crmacct_notes",          default: false, null: false
    t.boolean "crmacctsel_mrg_crmacct_owner_username", default: false, null: false
    t.boolean "crmacctsel_mrg_crmacct_parent_id",      default: false, null: false
    t.boolean "crmacctsel_mrg_crmacct_partner_id",     default: false, null: false
    t.boolean "crmacctsel_mrg_crmacct_prospect_id",    default: false, null: false
    t.boolean "crmacctsel_mrg_crmacct_salesrep_id",    default: false, null: false
    t.boolean "crmacctsel_mrg_crmacct_taxauth_id",     default: false, null: false
    t.boolean "crmacctsel_mrg_crmacct_type",           default: false, null: false
    t.boolean "crmacctsel_mrg_crmacct_usr_username",   default: false, null: false
    t.boolean "crmacctsel_mrg_crmacct_vend_id",        default: false, null: false
    t.boolean "crmacctsel_mrg_crmacct_number",         default: false, null: false
  end

  create_table "curr_rate", primary_key: "curr_rate_id", force: :cascade, comment: "Exchange Rates Between Base and Foreign Currencies" do |t|
    t.integer "curr_id",                                 null: false
    t.decimal "curr_rate",      precision: 16, scale: 8, null: false
    t.date    "curr_effective",                          null: false
    t.date    "curr_expires",                            null: false
    t.index ["curr_id", "curr_effective"], name: "curr_rate_curr_id_key", unique: true, using: :btree
  end

  create_table "curr_symbol", primary_key: "curr_id", force: :cascade, comment: "Currency Names, Symbols, and Abbreviations" do |t|
    t.boolean "curr_base",              default: false, null: false
    t.string  "curr_name",   limit: 50,                 null: false
    t.string  "curr_symbol", limit: 9,                  null: false
    t.string  "curr_abbr",   limit: 3,                  null: false
    t.index ["curr_abbr"], name: "curr_symbol_curr_abbr_key", unique: true, using: :btree
    t.index ["curr_name"], name: "curr_symbol_curr_name_key", unique: true, using: :btree
  end

  create_table "custform", primary_key: "custform_id", id: :integer, default: -> { "nextval(('\"custform_custform_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Customer Form assignment information" do |t|
    t.integer "custform_custtype_id"
    t.text    "custform_custtype"
    t.integer "custform_invoice_report_id",       comment: "Obsolete -- reference custform_invoice_report_name instead."
    t.integer "custform_creditmemo_report_id",    comment: "Obsolete -- reference custform_creditmemo_report_name instead."
    t.integer "custform_quote_report_id",         comment: "Obsolete -- reference custform_quote_report_name instead."
    t.integer "custform_packinglist_report_id",   comment: "Obsolete -- reference custform_packinglist_report_name instead."
    t.integer "custform_statement_report_id",     comment: "Obsolete -- reference custform_statement_report_name instead."
    t.integer "custform_sopicklist_report_id",    comment: "Obsolete -- reference custform_sopicklist_report_name instead."
    t.text    "custform_invoice_report_name"
    t.text    "custform_creditmemo_report_name"
    t.text    "custform_quote_report_name"
    t.text    "custform_packinglist_report_name"
    t.text    "custform_statement_report_name"
    t.text    "custform_sopicklist_report_name"
  end

  create_table "custgrp", primary_key: "custgrp_id", id: :integer, default: -> { "nextval(('\"custgrp_custgrp_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Customer Group information" do |t|
    t.text "custgrp_name",    null: false
    t.text "custgrp_descrip"
  end

  create_table "custgrpitem", primary_key: "custgrpitem_id", id: :integer, default: -> { "nextval(('\"custgrpitem_custgrpitem_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Customer Group Item information" do |t|
    t.integer "custgrpitem_custgrp_id"
    t.integer "custgrpitem_cust_id"
  end

  create_table "custinfo", primary_key: "cust_id", id: :integer, default: -> { "nextval(('cust_cust_id_seq'::text)::regclass)" }, force: :cascade, comment: "Customer information" do |t|
    t.boolean "cust_active",                                                                                          null: false
    t.integer "cust_custtype_id"
    t.integer "cust_salesrep_id"
    t.decimal "cust_commprcnt",                       precision: 10, scale: 6
    t.text    "cust_name"
    t.integer "cust_creditlmt"
    t.text    "cust_creditrating"
    t.boolean "cust_financecharge"
    t.boolean "cust_backorder",                                                                                       null: false
    t.boolean "cust_partialship",                                                                                     null: false
    t.integer "cust_terms_id"
    t.decimal "cust_discntprcnt",                     precision: 10, scale: 6,                                        null: false
    t.string  "cust_balmethod",             limit: 1,                                                                 null: false
    t.boolean "cust_ffshipto",                                                                                        null: false
    t.integer "cust_shipform_id"
    t.text    "cust_shipvia"
    t.boolean "cust_blanketpos",                                                                                      null: false
    t.integer "cust_shipchrg_id",                                                                                     null: false
    t.string  "cust_creditstatus",          limit: 1,                                                                 null: false
    t.text    "cust_comments"
    t.boolean "cust_ffbillto",                                                                                        null: false
    t.boolean "cust_usespos",                                                                                         null: false
    t.text    "cust_number",                                                                                          null: false
    t.date    "cust_dateadded",                                                default: -> { "('now'::text)::date" }
    t.boolean "cust_exported",                                                 default: false
    t.boolean "cust_emaildelivery",                                            default: false
    t.text    "cust_ediemail",                                                                                                     comment: "Deprecated column - DO NOT USE"
    t.text    "cust_edisubject",                                                                                                   comment: "Deprecated column - DO NOT USE"
    t.text    "cust_edifilename",                                                                                                  comment: "Deprecated column - DO NOT USE"
    t.text    "cust_ediemailbody",                                                                                                 comment: "Deprecated column - DO NOT USE"
    t.boolean "cust_autoupdatestatus",                                                                                null: false
    t.boolean "cust_autoholdorders",                                                                                  null: false
    t.text    "cust_edicc",                                                                                                        comment: "Deprecated column - DO NOT USE"
    t.integer "cust_ediprofile_id",                                                                                                comment: "Deprecated column - DO NOT USE"
    t.integer "cust_preferred_warehous_id",                                    default: -1,                           null: false
    t.integer "cust_curr_id",                                                  default: -> { "basecurrid()" }
    t.integer "cust_creditlmt_curr_id",                                        default: -> { "basecurrid()" }
    t.integer "cust_cntct_id"
    t.integer "cust_corrcntct_id"
    t.boolean "cust_soemaildelivery",                                          default: false
    t.text    "cust_soediemail",                                                                                                   comment: "Deprecated column - DO NOT USE"
    t.text    "cust_soedisubject",                                                                                                 comment: "Deprecated column - DO NOT USE"
    t.text    "cust_soedifilename",                                                                                                comment: "Deprecated column - DO NOT USE"
    t.text    "cust_soediemailbody",                                                                                               comment: "Deprecated column - DO NOT USE"
    t.text    "cust_soedicc",                                                                                                      comment: "Deprecated column - DO NOT USE"
    t.integer "cust_soediprofile_id",                                                                                              comment: "Deprecated column - DO NOT USE"
    t.integer "cust_gracedays"
    t.boolean "cust_ediemailhtml",                                             default: false,                        null: false, comment: "Deprecated column - DO NOT USE"
    t.boolean "cust_soediemailhtml",                                           default: false,                        null: false, comment: "Deprecated column - DO NOT USE"
    t.integer "cust_taxzone_id"
    t.text    "cust_statementcycle"
    t.index ["cust_number"], name: "cust_number_idx", unique: true, using: :btree
    t.index ["cust_number"], name: "custinfo_cust_number_key", unique: true, using: :btree
  end

  create_table "custtype", primary_key: "custtype_id", id: :integer, default: -> { "nextval(('custtype_custtype_id_seq'::text)::regclass)" }, force: :cascade, comment: "Customer Type information" do |t|
    t.text    "custtype_code",                    null: false
    t.text    "custtype_descrip",                 null: false
    t.boolean "custtype_char",    default: false, null: false
    t.index ["custtype_code"], name: "custtype_custtype_code_key", unique: true, using: :btree
  end

  create_table "dept", primary_key: "dept_id", force: :cascade, comment: "List of Departments" do |t|
    t.text "dept_number", null: false
    t.text "dept_name",   null: false
    t.index ["dept_number"], name: "dept_dept_number_key", unique: true, using: :btree
  end

  create_table "destination", primary_key: "destination_id", id: :integer, default: -> { "nextval(('\"destination_destination_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Destination information" do |t|
    t.text "destination_name"
    t.text "destination_city"
    t.text "destination_state"
    t.text "destination_comments"
  end

  create_table "docass", primary_key: "docass_id", force: :cascade, comment: "Document Assignement References" do |t|
    t.integer  "docass_source_id",                             null: false
    t.text     "docass_source_type",                           null: false
    t.integer  "docass_target_id",                             null: false
    t.text     "docass_target_type",           default: "URL", null: false
    t.string   "docass_purpose",     limit: 1, default: "S",   null: false
    t.text     "docass_username"
    t.datetime "docass_created"
    t.index ["docass_source_id"], name: "docass_source_id_idx", using: :btree
    t.index ["docass_source_type"], name: "docass_source_type_idx", using: :btree
    t.index ["docass_target_id"], name: "docass_target_id_idx", using: :btree
    t.index ["docass_target_type"], name: "docass_target_type_idx", using: :btree
  end

  create_table "emp", primary_key: "emp_id", force: :cascade, comment: "Employee table describing the basic properties of an employee. Employees need not be system users." do |t|
    t.text    "emp_code",                                                  null: false, comment: "Short, human-readable name for employee. This value is kept synchronized with usr_username and salesrep_number, and so is unique across all three tables emp, usr, and salesrep."
    t.text    "emp_number",                                                null: false, comment: "Official employee number. This might be used for ID badges, payroll accounting, or other purposes."
    t.boolean "emp_active",         default: true,                         null: false
    t.integer "emp_cntct_id"
    t.integer "emp_warehous_id"
    t.integer "emp_mgr_emp_id",                                                         comment: "Internal ID of this employee's manager/supervisor."
    t.text    "emp_wage_type",                                             null: false, comment: "The nature of the wage or employment agreement. 'H' indicates this employee is paid on an hourly basis (or some other period) while 'S' indicates this employee is salaried."
    t.decimal "emp_wage"
    t.integer "emp_wage_curr_id",   default: -> { "basecurrid()" }
    t.text    "emp_wage_period",                                           null: false, comment: "The periodicity of wage payment: 'H' for hourly, 'D' for daily, 'W' for weekly, 'BW' for biweekly, 'M' for monthly, 'Y' for yearly."
    t.integer "emp_dept_id"
    t.integer "emp_shift_id"
    t.text    "emp_notes"
    t.integer "emp_image_id"
    t.text    "emp_username",                                                           comment: "DEPRECATED - the relationship between Employee and User is now maintained through the crmacct table."
    t.decimal "emp_extrate"
    t.text    "emp_extrate_period",                                        null: false, comment: "The periodicity of external rate payment: 'H' for hourly, 'D' for daily, 'W' for weekly, 'BW' for biweekly, 'M' for monthly, 'Y' for yearly."
    t.date    "emp_startdate",      default: -> { "('now'::text)::date" }
    t.text    "emp_name",                                                  null: false
    t.index ["emp_code"], name: "emp_emp_code_key", unique: true, using: :btree
    t.index ["emp_number"], name: "emp_emp_number_key", unique: true, using: :btree
  end

  create_table "empgrp", primary_key: "empgrp_id", force: :cascade do |t|
    t.text "empgrp_name",    null: false
    t.text "empgrp_descrip", null: false
    t.index ["empgrp_name"], name: "empgrp_empgrp_name_key", unique: true, using: :btree
  end

  create_table "empgrpitem", primary_key: "empgrpitem_id", force: :cascade do |t|
    t.integer "empgrpitem_empgrp_id", null: false
    t.integer "empgrpitem_emp_id",    null: false
  end

  create_table "evntlog", primary_key: "evntlog_id", id: :integer, default: -> { "nextval(('evntlog_evntlog_id_seq'::text)::regclass)" }, force: :cascade, comment: "Event Notification history" do |t|
    t.datetime "evntlog_evnttime"
    t.integer  "evntlog_evnttype_id"
    t.integer  "evntlog_ord_id"
    t.datetime "evntlog_dispatched"
    t.text     "evntlog_action"
    t.integer  "evntlog_warehous_id"
    t.text     "evntlog_number"
    t.decimal  "evntlog_newvalue",              precision: 20, scale: 10
    t.decimal  "evntlog_oldvalue",              precision: 20, scale: 10
    t.date     "evntlog_newdate"
    t.date     "evntlog_olddate"
    t.string   "evntlog_ordtype",     limit: 2
    t.text     "evntlog_username"
    t.index ["evntlog_dispatched"], name: "evntlog_dispatched_idx", using: :btree
    t.index ["evntlog_username"], name: "evntlog_evntlog_username_idx", using: :btree
  end

  create_table "evntnot", primary_key: "evntnot_id", id: :integer, default: -> { "nextval(('evntnot_evntnot_id_seq'::text)::regclass)" }, force: :cascade, comment: "Temporary table for storing information about user Event Notification selections" do |t|
    t.integer "evntnot_evnttype_id"
    t.integer "evntnot_warehous_id"
    t.text    "evntnot_username"
    t.index ["evntnot_evnttype_id"], name: "evntnot_evnttype_id_idx", using: :btree
    t.index ["evntnot_warehous_id"], name: "evntnot_warehous_id_idx", using: :btree
  end

  create_table "evnttype", primary_key: "evnttype_id", id: :integer, default: -> { "nextval(('evnttype_evnttype_id_seq'::text)::regclass)" }, force: :cascade, comment: "Event Type information" do |t|
    t.text "evnttype_name",    null: false
    t.text "evnttype_descrip"
    t.text "evnttype_module"
    t.index ["evnttype_name"], name: "evnttype_evnttype_name_key", unique: true, using: :btree
  end

  create_table "examples", force: :cascade do |t|
    t.text     "text",       null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_examples_on_user_id", using: :btree
  end

  create_table "expcat", primary_key: "expcat_id", force: :cascade, comment: "Expense Category information" do |t|
    t.text    "expcat_code",                null: false
    t.text    "expcat_descrip"
    t.integer "expcat_exp_accnt_id"
    t.integer "expcat_liability_accnt_id"
    t.boolean "expcat_active"
    t.integer "expcat_purchprice_accnt_id"
    t.integer "expcat_freight_accnt_id"
    t.index ["expcat_code"], name: "expcat_expcat_code_key", unique: true, using: :btree
  end

  create_table "file", primary_key: "file_id", force: :cascade do |t|
    t.text   "file_title",   null: false
    t.binary "file_stream"
    t.text   "file_descrip", null: false
  end

  create_table "filter", primary_key: "filter_id", force: :cascade do |t|
    t.text    "filter_screen",                   null: false
    t.text    "filter_value",                    null: false
    t.text    "filter_username"
    t.text    "filter_name",                     null: false
    t.boolean "filter_selected", default: false
    t.index ["filter_screen", "filter_username", "filter_name"], name: "filter_idx", using: :btree
  end

  create_table "fincharg", primary_key: "fincharg_id", force: :cascade, comment: "Finance Charge configuration information" do |t|
    t.decimal "fincharg_mincharg",                  null: false
    t.integer "fincharg_graceperiod",               null: false
    t.boolean "fincharg_assessoverdue",             null: false
    t.integer "fincharg_calcfrom",                  null: false
    t.text    "fincharg_markoninvoice",             null: false
    t.decimal "fincharg_air",                       null: false
    t.integer "fincharg_accnt_id",                  null: false
    t.integer "fincharg_salescat_id",               null: false
    t.text    "fincharg_lastfc_statementcyclefrom"
    t.text    "fincharg_lastfc_custidfrom"
    t.text    "fincharg_lastfc_custidto"
    t.text    "fincharg_lastfc_statementcycleto"
  end

  create_table "flcol", primary_key: "flcol_id", force: :cascade do |t|
    t.integer "flcol_flhead_id",                 null: false
    t.text    "flcol_name"
    t.text    "flcol_descrip"
    t.integer "flcol_report_id"
    t.boolean "flcol_month"
    t.boolean "flcol_quarter"
    t.boolean "flcol_year"
    t.boolean "flcol_showdb"
    t.boolean "flcol_prcnt"
    t.string  "flcol_priortype",       limit: 1
    t.boolean "flcol_priormonth"
    t.boolean "flcol_priorquarter"
    t.string  "flcol_prioryear",       limit: 1
    t.boolean "flcol_priorprcnt"
    t.boolean "flcol_priordiff"
    t.boolean "flcol_priordiffprcnt"
    t.boolean "flcol_budget"
    t.boolean "flcol_budgetprcnt"
    t.boolean "flcol_budgetdiff"
    t.boolean "flcol_budgetdiffprcnt"
  end

  create_table "flgrp", primary_key: "flgrp_id", force: :cascade, comment: "Financial Layout Group information" do |t|
    t.integer "flgrp_flhead_id"
    t.integer "flgrp_flgrp_id"
    t.integer "flgrp_order"
    t.text    "flgrp_name"
    t.text    "flgrp_descrip"
    t.boolean "flgrp_subtotal",        default: false, null: false
    t.boolean "flgrp_summarize",       default: false, null: false
    t.boolean "flgrp_subtract",        default: false, null: false
    t.boolean "flgrp_showstart",       default: true,  null: false
    t.boolean "flgrp_showend",         default: true,  null: false
    t.boolean "flgrp_showdelta",       default: true,  null: false
    t.boolean "flgrp_showbudget",      default: true,  null: false
    t.boolean "flgrp_showstartprcnt",  default: false, null: false
    t.boolean "flgrp_showendprcnt",    default: false, null: false
    t.boolean "flgrp_showdeltaprcnt",  default: false, null: false
    t.boolean "flgrp_showbudgetprcnt", default: false, null: false
    t.integer "flgrp_prcnt_flgrp_id",  default: -1,    null: false
    t.boolean "flgrp_showdiff",        default: false, null: false
    t.boolean "flgrp_showdiffprcnt",   default: false, null: false
    t.boolean "flgrp_showcustom",      default: false, null: false
    t.boolean "flgrp_showcustomprcnt", default: false, null: false
    t.boolean "flgrp_usealtsubtotal",  default: false, null: false
    t.text    "flgrp_altsubtotal"
  end

  create_table "flhead", primary_key: "flhead_id", force: :cascade, comment: "Financial Layout header information" do |t|
    t.text    "flhead_name",                                    null: false
    t.text    "flhead_descrip"
    t.boolean "flhead_showtotal",               default: false, null: false
    t.boolean "flhead_showstart",               default: true,  null: false
    t.boolean "flhead_showend",                 default: true,  null: false
    t.boolean "flhead_showdelta",               default: true,  null: false
    t.boolean "flhead_showbudget",              default: true,  null: false
    t.boolean "flhead_showdiff",                default: false, null: false
    t.boolean "flhead_showcustom",              default: false, null: false
    t.text    "flhead_custom_label"
    t.boolean "flhead_usealttotal",             default: false, null: false
    t.text    "flhead_alttotal"
    t.boolean "flhead_usealtbegin",             default: false, null: false
    t.text    "flhead_altbegin"
    t.boolean "flhead_usealtend",               default: false, null: false
    t.text    "flhead_altend"
    t.boolean "flhead_usealtdebits",            default: false, null: false
    t.text    "flhead_altdebits"
    t.boolean "flhead_usealtcredits",           default: false, null: false
    t.text    "flhead_altcredits"
    t.boolean "flhead_usealtbudget",            default: false, null: false
    t.text    "flhead_altbudget"
    t.boolean "flhead_usealtdiff",              default: false, null: false
    t.text    "flhead_altdiff"
    t.string  "flhead_type",          limit: 1, default: "A",   null: false
    t.boolean "flhead_active",                  default: true,  null: false
    t.boolean "flhead_sys",                     default: false
    t.text    "flhead_notes",                   default: ""
    t.index ["flhead_name"], name: "flhead_flhead_name_key", unique: true, using: :btree
  end

  create_table "flitem", primary_key: "flitem_id", force: :cascade, comment: "Financial Layout Account information" do |t|
    t.integer "flitem_flhead_id"
    t.integer "flitem_flgrp_id"
    t.integer "flitem_order"
    t.integer "flitem_accnt_id"
    t.boolean "flitem_showstart"
    t.boolean "flitem_showend"
    t.boolean "flitem_showdelta"
    t.boolean "flitem_showbudget",                  default: false, null: false
    t.boolean "flitem_subtract",                    default: false, null: false
    t.boolean "flitem_showstartprcnt",              default: false, null: false
    t.boolean "flitem_showendprcnt",                default: false, null: false
    t.boolean "flitem_showdeltaprcnt",              default: false, null: false
    t.boolean "flitem_showbudgetprcnt",             default: false, null: false
    t.integer "flitem_prcnt_flgrp_id",              default: -1,    null: false
    t.boolean "flitem_showdiff",                    default: false, null: false
    t.boolean "flitem_showdiffprcnt",               default: false, null: false
    t.boolean "flitem_showcustom",                  default: false, null: false
    t.boolean "flitem_showcustomprcnt",             default: false, null: false
    t.string  "flitem_custom_source",     limit: 1
    t.text    "flitem_company"
    t.text    "flitem_profit"
    t.text    "flitem_number"
    t.text    "flitem_sub"
    t.string  "flitem_type",              limit: 1
    t.text    "flitem_subaccnttype_code"
  end

  create_table "flnotes", id: false, force: :cascade do |t|
    t.serial  "flnotes_id",                     null: false
    t.integer "flnotes_flhead_id"
    t.integer "flnotes_period_id"
    t.text    "flnotes_notes",     default: ""
    t.index ["flnotes_flhead_id", "flnotes_period_id"], name: "flnotes_flnotes_flhead_id_key", unique: true, using: :btree
  end

  create_table "flrpt", primary_key: "flrpt_id", force: :cascade, comment: "Scratch table where financial reporting information is processed before being displayed." do |t|
    t.integer "flrpt_flhead_id",                null: false
    t.integer "flrpt_period_id",                null: false
    t.text    "flrpt_username",                 null: false
    t.integer "flrpt_order",                    null: false
    t.integer "flrpt_level",                    null: false
    t.text    "flrpt_type",                     null: false
    t.integer "flrpt_type_id",                  null: false
    t.decimal "flrpt_beginning"
    t.decimal "flrpt_ending"
    t.decimal "flrpt_debits"
    t.decimal "flrpt_credits"
    t.decimal "flrpt_budget"
    t.decimal "flrpt_beginningprcnt"
    t.decimal "flrpt_endingprcnt"
    t.decimal "flrpt_debitsprcnt"
    t.decimal "flrpt_creditsprcnt"
    t.decimal "flrpt_budgetprcnt"
    t.integer "flrpt_parent_id"
    t.decimal "flrpt_diff"
    t.decimal "flrpt_diffprcnt"
    t.decimal "flrpt_custom"
    t.decimal "flrpt_customprcnt"
    t.text    "flrpt_altname"
    t.integer "flrpt_accnt_id"
    t.string  "flrpt_interval",       limit: 1
  end

  create_table "flspec", primary_key: "flspec_id", force: :cascade, comment: "Financial Layout Special entries." do |t|
    t.integer "flspec_flhead_id",                                 null: false
    t.integer "flspec_flgrp_id",                                  null: false
    t.integer "flspec_order",                                     null: false
    t.text    "flspec_name"
    t.text    "flspec_type"
    t.boolean "flspec_showstart",                 default: true,  null: false
    t.boolean "flspec_showend",                   default: true,  null: false
    t.boolean "flspec_showdelta",                 default: true,  null: false
    t.boolean "flspec_showbudget",                default: false, null: false
    t.boolean "flspec_subtract",                  default: false, null: false
    t.boolean "flspec_showstartprcnt",            default: false, null: false
    t.boolean "flspec_showendprcnt",              default: false, null: false
    t.boolean "flspec_showdeltaprcnt",            default: false, null: false
    t.boolean "flspec_showbudgetprcnt",           default: false, null: false
    t.boolean "flspec_showdiff",                  default: false, null: false
    t.boolean "flspec_showdiffprcnt",             default: false, null: false
    t.integer "flspec_prcnt_flgrp_id",            default: -1,    null: false
    t.boolean "flspec_showcustom",                default: false, null: false
    t.boolean "flspec_showcustomprcnt",           default: false, null: false
    t.string  "flspec_custom_source",   limit: 1
  end

  create_table "form", primary_key: "form_id", id: :integer, default: -> { "nextval(('\"form_form_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Form information" do |t|
    t.text    "form_name",                  null: false
    t.text    "form_descrip"
    t.integer "form_report_id",                          comment: "Obsolete -- reference form_report_name instead."
    t.string  "form_key",         limit: 4
    t.text    "form_report_name"
    t.index ["form_name"], name: "form_form_name_key", unique: true, using: :btree
  end

  create_table "freightclass", primary_key: "freightclass_id", force: :cascade, comment: "This table is the freight price schedules." do |t|
    t.text "freightclass_code",    null: false
    t.text "freightclass_descrip"
    t.index ["freightclass_code"], name: "freightclass_freightclass_code_key", unique: true, using: :btree
  end

  create_table "glseries", primary_key: "glseries_id", id: :integer, default: -> { "nextval(('\"glseries_glseries_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Temporary table for storing information about General Ledger (G/L) Series Entries before Series Entries are posted" do |t|
    t.integer "glseries_sequence"
    t.string  "glseries_doctype",   limit: 2
    t.text    "glseries_docnumber"
    t.integer "glseries_accnt_id"
    t.decimal "glseries_amount",              precision: 20, scale: 2
    t.text    "glseries_source"
    t.date    "glseries_distdate"
    t.text    "glseries_notes"
    t.integer "glseries_misc_id"
  end

  create_table "gltrans", primary_key: "gltrans_id", id: :integer, default: -> { "nextval(('\"gltrans_gltrans_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "General Ledger (G/L) transaction information" do |t|
    t.boolean  "gltrans_exported"
    t.datetime "gltrans_created"
    t.date     "gltrans_date",                                                                           null: false
    t.integer  "gltrans_sequence"
    t.integer  "gltrans_accnt_id",                                                                       null: false
    t.text     "gltrans_source"
    t.text     "gltrans_docnumber"
    t.integer  "gltrans_misc_id"
    t.decimal  "gltrans_amount",        precision: 20, scale: 2,                                         null: false
    t.text     "gltrans_notes"
    t.integer  "gltrans_journalnumber"
    t.boolean  "gltrans_posted",                                                                         null: false
    t.text     "gltrans_doctype"
    t.boolean  "gltrans_rec",                                    default: false,                         null: false
    t.text     "gltrans_username",                               default: -> { "geteffectivextuser()" }, null: false
    t.boolean  "gltrans_deleted",                                default: false
    t.index ["gltrans_accnt_id"], name: "gltrans_gltrans_accnt_id_idx", using: :btree
    t.index ["gltrans_date"], name: "gltrans_gltrans_date_idx", using: :btree
    t.index ["gltrans_journalnumber"], name: "gltrans_gltrans_journalnumber_idx", using: :btree
    t.index ["gltrans_sequence"], name: "gltrans_sequence_idx", using: :btree
  end

  create_table "gltranssync", primary_key: "gltrans_id", id: :integer, default: -> { "nextval(('\"gltrans_gltrans_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Trial balance synchronization table used to import G/L transaction data summarized by day for assets and liabilities." do |t|
    t.boolean  "gltrans_exported"
    t.datetime "gltrans_created"
    t.date     "gltrans_date",                                                                             null: false
    t.integer  "gltrans_sequence"
    t.integer  "gltrans_accnt_id",                                                                         null: false
    t.text     "gltrans_source"
    t.text     "gltrans_docnumber"
    t.integer  "gltrans_misc_id"
    t.decimal  "gltrans_amount",          precision: 20, scale: 2,                                         null: false
    t.text     "gltrans_notes"
    t.integer  "gltrans_journalnumber"
    t.boolean  "gltrans_posted",                                                                           null: false
    t.text     "gltrans_doctype"
    t.boolean  "gltrans_rec",                                      default: false,                         null: false
    t.text     "gltrans_username",                                 default: -> { "geteffectivextuser()" }, null: false
    t.boolean  "gltrans_deleted",                                  default: false
    t.integer  "gltranssync_period_id",                                                                    null: false, comment: "Period table reference"
    t.integer  "gltranssync_company_id",                                                                   null: false, comment: "Company table reference"
    t.decimal  "gltranssync_curr_amount", precision: 20, scale: 2,                                         null: false, comment: "Amount in source transaction currency"
    t.integer  "gltranssync_curr_id",                                                                      null: false, comment: "Currency table reference"
    t.decimal  "gltranssync_curr_rate",                                                                    null: false, comment: "Currency conversion rate applied"
  end

  create_table "grp", primary_key: "grp_id", force: :cascade, comment: "This table is the basic group information." do |t|
    t.text "grp_name",    null: false
    t.text "grp_descrip"
    t.index ["grp_name"], name: "grp_grp_name_key", unique: true, using: :btree
  end

  create_table "grppriv", primary_key: "grppriv_id", force: :cascade, comment: "This is a specific priv for a specific group." do |t|
    t.integer "grppriv_grp_id",  null: false
    t.integer "grppriv_priv_id", null: false
  end

  create_table "hnfc", primary_key: "hnfc_id", force: :cascade, comment: "List of personal titles/honorifics used in cntct table." do |t|
    t.text "hnfc_code", null: false
    t.index ["hnfc_code"], name: "hnfc_hnfc_code_key", unique: true, using: :btree
  end

  create_table "image", primary_key: "image_id", id: :integer, default: -> { "nextval(('\"image_image_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Image information" do |t|
    t.text "image_name"
    t.text "image_descrip"
    t.text "image_data"
  end

  create_table "imageass", primary_key: "imageass_id", id: :integer, default: -> { "nextval('docass_docass_id_seq'::regclass)" }, force: :cascade, comment: "Image Assignement References" do |t|
    t.integer "imageass_source_id",           null: false
    t.text    "imageass_source",              null: false
    t.integer "imageass_image_id",            null: false
    t.string  "imageass_purpose",   limit: 1, null: false
  end

  create_table "incdt", primary_key: "incdt_id", force: :cascade, comment: "Incident table" do |t|
    t.integer  "incdt_number",                                                null: false
    t.integer  "incdt_crmacct_id"
    t.integer  "incdt_cntct_id"
    t.text     "incdt_summary"
    t.text     "incdt_descrip"
    t.integer  "incdt_item_id"
    t.datetime "incdt_timestamp",                    default: -> { "now()" }, null: false
    t.string   "incdt_status",             limit: 1, default: "N",            null: false
    t.text     "incdt_assigned_username"
    t.integer  "incdt_incdtcat_id"
    t.integer  "incdt_incdtseverity_id"
    t.integer  "incdt_incdtpriority_id"
    t.integer  "incdt_incdtresolution_id"
    t.text     "incdt_lotserial",                                                          comment: "incdt_lotserial is deprecated"
    t.integer  "incdt_ls_id"
    t.integer  "incdt_aropen_id"
    t.text     "incdt_owner_username"
    t.integer  "incdt_recurring_incdt_id",                                                 comment: "The first incdt record in the series if this is a recurring Incident. If the incdt_recurring_incdt_id is the same as the incdt_id, this record is the first in the series."
    t.datetime "incdt_updated",                      default: -> { "now()" }, null: false
    t.integer  "incdt_prj_id"
    t.boolean  "incdt_public"
    t.index ["incdt_number"], name: "incdt_incdt_number_key", unique: true, using: :btree
  end

  create_table "incdtcat", primary_key: "incdtcat_id", force: :cascade, comment: "Incident Category table" do |t|
    t.text    "incdtcat_name",          null: false
    t.integer "incdtcat_order"
    t.text    "incdtcat_descrip"
    t.integer "incdtcat_ediprofile_id"
    t.index ["incdtcat_name"], name: "incdtcat_incdtcat_name_key", unique: true, using: :btree
  end

  create_table "incdthist", primary_key: "incdthist_id", force: :cascade, comment: "Incident history changes" do |t|
    t.integer  "incdthist_incdt_id",                                                    null: false
    t.string   "incdthist_change",    limit: 1
    t.integer  "incdthist_target_id"
    t.datetime "incdthist_timestamp",           default: -> { "now()" },                null: false
    t.text     "incdthist_username",            default: -> { "geteffectivextuser()" }, null: false
    t.text     "incdthist_descrip"
  end

  create_table "incdtpriority", primary_key: "incdtpriority_id", force: :cascade, comment: "Incident Priority table" do |t|
    t.text    "incdtpriority_name",    null: false
    t.integer "incdtpriority_order"
    t.text    "incdtpriority_descrip"
    t.index ["incdtpriority_name"], name: "incdtpriority_incdtpriority_name_key", unique: true, using: :btree
  end

  create_table "incdtresolution", primary_key: "incdtresolution_id", force: :cascade, comment: "Incident Resolution table" do |t|
    t.text    "incdtresolution_name",    null: false
    t.integer "incdtresolution_order"
    t.text    "incdtresolution_descrip"
    t.index ["incdtresolution_name"], name: "incdtresolution_incdtresolution_name_key", unique: true, using: :btree
  end

  create_table "incdtseverity", primary_key: "incdtseverity_id", force: :cascade, comment: "Incident Severity table" do |t|
    t.text    "incdtseverity_name",    null: false
    t.integer "incdtseverity_order"
    t.text    "incdtseverity_descrip"
    t.index ["incdtseverity_name"], name: "incdtseverity_incdtseverity_name_key", unique: true, using: :btree
  end

  create_table "invbal", primary_key: "invbal_id", force: :cascade do |t|
    t.integer "invbal_period_id"
    t.integer "invbal_itemsite_id"
    t.decimal "invbal_qoh_beginning",   precision: 18, scale: 6,                null: false
    t.decimal "invbal_qoh_ending",      precision: 18, scale: 6,                null: false
    t.decimal "invbal_qty_in",          precision: 18, scale: 6,                null: false
    t.decimal "invbal_qty_out",         precision: 18, scale: 6,                null: false
    t.decimal "invbal_value_beginning", precision: 12, scale: 2,                null: false
    t.decimal "invbal_value_ending",    precision: 12, scale: 2,                null: false
    t.decimal "invbal_value_in",        precision: 12, scale: 2,                null: false
    t.decimal "invbal_value_out",       precision: 12, scale: 2,                null: false
    t.decimal "invbal_nn_beginning",    precision: 18, scale: 6,                null: false
    t.decimal "invbal_nn_ending",       precision: 18, scale: 6,                null: false
    t.decimal "invbal_nn_in",           precision: 18, scale: 6,                null: false
    t.decimal "invbal_nn_out",          precision: 18, scale: 6,                null: false
    t.decimal "invbal_nnval_beginning", precision: 12, scale: 2,                null: false
    t.decimal "invbal_nnval_ending",    precision: 12, scale: 2,                null: false
    t.decimal "invbal_nnval_in",        precision: 12, scale: 2,                null: false
    t.decimal "invbal_nnval_out",       precision: 12, scale: 2,                null: false
    t.boolean "invbal_dirty",                                    default: true, null: false
  end

  create_table "invchead", primary_key: "invchead_id", force: :cascade, comment: "Invoice header information" do |t|
    t.integer "invchead_cust_id",                                                                         null: false
    t.integer "invchead_shipto_id"
    t.text    "invchead_ordernumber"
    t.date    "invchead_orderdate"
    t.boolean "invchead_posted",                                                                          null: false
    t.boolean "invchead_printed",                                                                         null: false
    t.text    "invchead_invcnumber",                                                                      null: false
    t.date    "invchead_invcdate",                                                                        null: false
    t.date    "invchead_shipdate"
    t.text    "invchead_ponumber"
    t.text    "invchead_shipvia"
    t.text    "invchead_fob"
    t.text    "invchead_billto_name"
    t.text    "invchead_billto_address1"
    t.text    "invchead_billto_address2"
    t.text    "invchead_billto_address3"
    t.text    "invchead_billto_city"
    t.text    "invchead_billto_state"
    t.text    "invchead_billto_zipcode"
    t.text    "invchead_billto_phone"
    t.text    "invchead_shipto_name"
    t.text    "invchead_shipto_address1"
    t.text    "invchead_shipto_address2"
    t.text    "invchead_shipto_address3"
    t.text    "invchead_shipto_city"
    t.text    "invchead_shipto_state"
    t.text    "invchead_shipto_zipcode"
    t.text    "invchead_shipto_phone"
    t.integer "invchead_salesrep_id"
    t.decimal "invchead_commission",            precision: 20, scale: 10,                                 null: false
    t.integer "invchead_terms_id"
    t.decimal "invchead_freight",               precision: 16, scale: 2,                                  null: false
    t.decimal "invchead_misc_amount",           precision: 16, scale: 2,                                  null: false
    t.text    "invchead_misc_descrip"
    t.integer "invchead_misc_accnt_id"
    t.decimal "invchead_payment",               precision: 16, scale: 2
    t.text    "invchead_paymentref"
    t.text    "invchead_notes"
    t.text    "invchead_billto_country"
    t.text    "invchead_shipto_country"
    t.integer "invchead_prj_id"
    t.integer "invchead_curr_id",                                         default: -> { "basecurrid()" }
    t.date    "invchead_gldistdate"
    t.boolean "invchead_recurring",                                       default: false,                 null: false, comment: "Deprecated."
    t.integer "invchead_recurring_interval",                                                                           comment: "Deprecated."
    t.text    "invchead_recurring_type",                                                                               comment: "Deprecated."
    t.date    "invchead_recurring_until",                                                                              comment: "Deprecated."
    t.integer "invchead_recurring_invchead_id"
    t.integer "invchead_shipchrg_id"
    t.integer "invchead_taxzone_id"
    t.boolean "invchead_void",                                            default: false
    t.integer "invchead_saletype_id",                                                                                  comment: "Associated sale type for invoice."
    t.integer "invchead_shipzone_id",                                                                                  comment: "Associated shipping zone for invoice."
    t.index ["invchead_cust_id"], name: "invchead_invchead_cust_id_idx", using: :btree
    t.index ["invchead_invcnumber"], name: "invchead_invcnumber_unique", unique: true, using: :btree
    t.index ["invchead_ordernumber"], name: "invchead_invchead_ordernumber_idx", using: :btree
  end

  create_table "invcheadtax", primary_key: "taxhist_id", id: :integer, default: -> { "nextval('taxhist_taxhist_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "taxhist_parent_id",                              null: false
    t.integer "taxhist_taxtype_id"
    t.integer "taxhist_tax_id",                                 null: false
    t.decimal "taxhist_basis",         precision: 16, scale: 2, null: false
    t.integer "taxhist_basis_tax_id"
    t.integer "taxhist_sequence"
    t.decimal "taxhist_percent",       precision: 10, scale: 6, null: false
    t.decimal "taxhist_amount",        precision: 16, scale: 2, null: false
    t.decimal "taxhist_tax",           precision: 16, scale: 6, null: false
    t.date    "taxhist_docdate",                                null: false
    t.date    "taxhist_distdate"
    t.integer "taxhist_curr_id"
    t.decimal "taxhist_curr_rate"
    t.integer "taxhist_journalnumber"
    t.index ["taxhist_parent_id", "taxhist_taxtype_id"], name: "invcheadtax_taxhist_parent_type_idx", using: :btree
    t.index ["taxhist_parent_id"], name: "invcheadtax_taxhist_parent_id_idx", using: :btree
    t.index ["taxhist_taxtype_id"], name: "invcheadtax_taxhist_taxtype_id_idx", using: :btree
  end

  create_table "invcitem", primary_key: "invcitem_id", force: :cascade, comment: "Invoice Line Item information" do |t|
    t.integer "invcitem_invchead_id",                                                 null: false
    t.integer "invcitem_linenumber"
    t.integer "invcitem_item_id"
    t.integer "invcitem_warehous_id",                                 default: -1
    t.text    "invcitem_custpn"
    t.text    "invcitem_number"
    t.text    "invcitem_descrip"
    t.decimal "invcitem_ordered",           precision: 20, scale: 6,                  null: false
    t.decimal "invcitem_billed",            precision: 20, scale: 6,                  null: false
    t.decimal "invcitem_custprice",         precision: 20, scale: 4
    t.decimal "invcitem_price",             precision: 20, scale: 4,                  null: false
    t.text    "invcitem_notes"
    t.integer "invcitem_salescat_id"
    t.integer "invcitem_taxtype_id"
    t.integer "invcitem_qty_uom_id"
    t.decimal "invcitem_qty_invuomratio",   precision: 20, scale: 10,                 null: false
    t.integer "invcitem_price_uom_id"
    t.decimal "invcitem_price_invuomratio", precision: 20, scale: 10,                 null: false
    t.integer "invcitem_coitem_id"
    t.boolean "invcitem_updateinv",                                   default: false
    t.integer "invcitem_rev_accnt_id"
    t.index ["invcitem_invchead_id", "invcitem_linenumber"], name: "invcitem_invchead_id_linenumber_unique", unique: true, using: :btree
    t.index ["invcitem_invchead_id"], name: "invcitem_invcitem_invchead_id_idx", using: :btree
    t.index ["invcitem_item_id", "invcitem_warehous_id"], name: "invcitem_invcitem_itemsite_id_idx", using: :btree
  end

  create_table "invcitemtax", primary_key: "taxhist_id", id: :integer, default: -> { "nextval('taxhist_taxhist_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "taxhist_parent_id",                              null: false
    t.integer "taxhist_taxtype_id"
    t.integer "taxhist_tax_id",                                 null: false
    t.decimal "taxhist_basis",         precision: 16, scale: 2, null: false
    t.integer "taxhist_basis_tax_id"
    t.integer "taxhist_sequence"
    t.decimal "taxhist_percent",       precision: 10, scale: 6, null: false
    t.decimal "taxhist_amount",        precision: 16, scale: 2, null: false
    t.decimal "taxhist_tax",           precision: 16, scale: 6, null: false
    t.date    "taxhist_docdate",                                null: false
    t.date    "taxhist_distdate"
    t.integer "taxhist_curr_id"
    t.decimal "taxhist_curr_rate"
    t.integer "taxhist_journalnumber"
    t.index ["taxhist_parent_id", "taxhist_taxtype_id"], name: "invcitemtax_taxhist_parent_type_idx", using: :btree
    t.index ["taxhist_parent_id"], name: "invcitemtax_taxhist_parent_id_idx", using: :btree
    t.index ["taxhist_taxtype_id"], name: "invcitemtax_taxhist_taxtype_id_idx", using: :btree
  end

  create_table "invcnt", primary_key: "invcnt_id", id: :integer, default: -> { "nextval(('invcnt_invcnt_id_seq'::text)::regclass)" }, force: :cascade, comment: "Count Tag information" do |t|
    t.integer  "invcnt_itemsite_id"
    t.datetime "invcnt_tagdate"
    t.datetime "invcnt_cntdate"
    t.decimal  "invcnt_qoh_before",    precision: 18, scale: 6
    t.decimal  "invcnt_qoh_after",     precision: 18, scale: 6
    t.decimal  "invcnt_matcost",       precision: 16, scale: 6
    t.boolean  "invcnt_posted"
    t.datetime "invcnt_postdate"
    t.text     "invcnt_comments"
    t.boolean  "invcnt_priority"
    t.text     "invcnt_tagnumber"
    t.integer  "invcnt_invhist_id"
    t.integer  "invcnt_location_id"
    t.text     "invcnt_cnt_username"
    t.text     "invcnt_post_username"
    t.text     "invcnt_tag_username"
  end

  create_table "invdetail", primary_key: "invdetail_id", id: :integer, default: -> { "nextval(('\"invdetail_invdetail_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Detailed Inventory transaction information for Lot/Serial and Multiple Location Control (MLC) Items" do |t|
    t.string  "invdetail_transtype",   limit: 2
    t.integer "invdetail_invhist_id"
    t.integer "invdetail_location_id"
    t.decimal "invdetail_qty",                   precision: 18, scale: 6
    t.text    "invdetail_comments"
    t.decimal "invdetail_qty_before",            precision: 18, scale: 6
    t.decimal "invdetail_qty_after",             precision: 18, scale: 6
    t.integer "invdetail_invcitem_id"
    t.date    "invdetail_expiration"
    t.date    "invdetail_warrpurc"
    t.integer "invdetail_ls_id"
    t.index ["invdetail_invcitem_id"], name: "invdetail_invdetail_invcitem_id_idx", using: :btree
    t.index ["invdetail_invhist_id"], name: "invdetail_invdetail_invhist_id_idx", using: :btree
  end

  create_table "invhist", primary_key: "invhist_id", id: :integer, default: -> { "nextval(('invhist_invhist_id_seq'::text)::regclass)" }, force: :cascade, comment: "Inventory transaction history" do |t|
    t.integer  "invhist_itemsite_id"
    t.datetime "invhist_transdate",                                           default: -> { "('now'::text)::timestamp(6) with time zone" }
    t.string   "invhist_transtype",        limit: 2
    t.decimal  "invhist_invqty",                     precision: 18, scale: 6
    t.text     "invhist_invuom"
    t.text     "invhist_ordnumber"
    t.text     "invhist_docnumber"
    t.decimal  "invhist_qoh_before",                 precision: 18, scale: 6
    t.decimal  "invhist_qoh_after",                  precision: 18, scale: 6
    t.decimal  "invhist_unitcost",                   precision: 16, scale: 6
    t.integer  "invhist_acct_id"
    t.integer  "invhist_xfer_warehous_id"
    t.text     "invhist_comments"
    t.boolean  "invhist_posted",                                              default: true
    t.boolean  "invhist_imported"
    t.boolean  "invhist_hasdetail",                                           default: false
    t.text     "invhist_ordtype"
    t.boolean  "invhist_analyze",                                             default: true
    t.text     "invhist_user",                                                default: -> { "geteffectivextuser()" }
    t.datetime "invhist_created",                                             default: -> { "now()" },                                      null: false
    t.string   "invhist_costmethod",       limit: 1,                                                                                        null: false
    t.decimal  "invhist_value_before",               precision: 12, scale: 2,                                                               null: false
    t.decimal  "invhist_value_after",                precision: 12, scale: 2,                                                               null: false
    t.integer  "invhist_series"
    t.index ["invhist_hasdetail"], name: "invhist_hasdetail", using: :btree
    t.index ["invhist_itemsite_id"], name: "invhist_itemsite_id", using: :btree
    t.index ["invhist_ordnumber"], name: "invhist_invhist_ordnumber_idx", using: :btree
    t.index ["invhist_series"], name: "invhist_series", using: :btree
    t.index ["invhist_transdate"], name: "invhist_transdate", using: :btree
    t.index ["invhist_transtype"], name: "invhist_transtype", using: :btree
  end

  create_table "invhistexpcat", primary_key: "invhistexpcat_id", force: :cascade, comment: "Track the relationship between an EX transaction in the invhist table and the corresponding Expense Category." do |t|
    t.integer "invhistexpcat_invhist_id", null: false
    t.integer "invhistexpcat_expcat_id",  null: false
    t.index ["invhistexpcat_invhist_id", "invhistexpcat_expcat_id"], name: "invhistexpcat_invhist_id_expcat_id", unique: true, using: :btree
  end

  create_table "ipsass", primary_key: "ipsass_id", force: :cascade, comment: "Pricing Schedule assignment information" do |t|
    t.integer "ipsass_ipshead_id",                    null: false
    t.integer "ipsass_cust_id"
    t.integer "ipsass_custtype_id"
    t.text    "ipsass_custtype_pattern"
    t.integer "ipsass_shipto_id",        default: -1
    t.text    "ipsass_shipto_pattern"
    t.index ["ipsass_ipshead_id", "ipsass_cust_id", "ipsass_custtype_id", "ipsass_custtype_pattern", "ipsass_shipto_id", "ipsass_shipto_pattern"], name: "ipsass_ipsass_ipshead_id_key", unique: true, using: :btree
  end

  create_table "ipsfreight", primary_key: "ipsfreight_id", force: :cascade do |t|
    t.integer "ipsfreight_ipshead_id",                                null: false
    t.decimal "ipsfreight_qtybreak",                  default: "0.0", null: false
    t.decimal "ipsfreight_price",                     default: "0.0", null: false
    t.string  "ipsfreight_type",            limit: 1,                 null: false
    t.integer "ipsfreight_warehous_id"
    t.integer "ipsfreight_shipzone_id"
    t.integer "ipsfreight_freightclass_id"
    t.text    "ipsfreight_shipvia"
  end

  create_table "ipshead", primary_key: "ipshead_id", id: :integer, default: -> { "nextval(('\"ipshead_ipshead_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Pricing Schedule header information" do |t|
    t.text    "ipshead_name",                                      null: false
    t.text    "ipshead_descrip"
    t.date    "ipshead_effective"
    t.date    "ipshead_expires"
    t.integer "ipshead_curr_id",   default: -> { "basecurrid()" }, null: false
    t.date    "ipshead_updated"
    t.index ["ipshead_name"], name: "ipshead_ipshead_name_key", unique: true, using: :btree
  end

  create_table "ipsitemchar", primary_key: "ipsitemchar_id", force: :cascade, comment: "Item Price Schedule Characteristic Prices." do |t|
    t.integer "ipsitemchar_ipsitem_id",                          null: false
    t.integer "ipsitemchar_char_id",                             null: false
    t.text    "ipsitemchar_value",                               null: false
    t.decimal "ipsitemchar_price",      precision: 16, scale: 4
    t.index ["ipsitemchar_ipsitem_id", "ipsitemchar_char_id", "ipsitemchar_value"], name: "ipsitemchar_ipsitemchar_ipsitem_id_key", unique: true, using: :btree
    t.index ["ipsitemchar_ipsitem_id", "ipsitemchar_char_id", "ipsitemchar_value"], name: "ipsitemchar_ipsitemchar_ipsitem_id_key1", unique: true, using: :btree
  end

  create_table "ipsiteminfo", primary_key: "ipsitem_id", id: :integer, default: -> { "nextval(('\"ipsitem_ipsitem_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Pricing Schedule Item information" do |t|
    t.integer "ipsitem_ipshead_id"
    t.integer "ipsitem_item_id"
    t.decimal "ipsitem_qtybreak",                   precision: 18, scale: 6,                 null: false
    t.decimal "ipsitem_price",                      precision: 16, scale: 4,                 null: false
    t.integer "ipsitem_qty_uom_id"
    t.integer "ipsitem_price_uom_id"
    t.decimal "ipsitem_discntprcnt",                precision: 10, scale: 6, default: "0.0", null: false
    t.decimal "ipsitem_fixedamtdiscount",           precision: 16, scale: 4, default: "0.0", null: false
    t.integer "ipsitem_prodcat_id",                                                                       comment: "Product category for pricing schedule item."
    t.string  "ipsitem_type",             limit: 1,                                          null: false, comment: "Pricing type for pricing schedule item.  Valid values are N-nominal, D-discount, and M-markup"
    t.integer "ipsitem_warehous_id",                                                                      comment: "Site for pricing schedule item which enables pricing by site."
    t.index ["ipsitem_ipshead_id", "ipsitem_item_id", "ipsitem_prodcat_id", "ipsitem_qtybreak", "ipsitem_qty_uom_id", "ipsitem_price_uom_id"], name: "ipsitem_ipsitem_ipshead_id_key", unique: true, using: :btree
    t.index ["ipsitem_ipshead_id"], name: "ipsitem_ipshead_id_idx", using: :btree
  end

  create_table "ipsprodcat_bak", primary_key: "ipsprodcat_id", id: :integer, default: -> { "nextval('ipsprodcat_ipsprodcat_id_seq'::regclass)" }, force: :cascade, comment: "Pricing Schedule Product Category information." do |t|
    t.integer "ipsprodcat_ipshead_id",                                                null: false
    t.integer "ipsprodcat_prodcat_id",                                                null: false
    t.decimal "ipsprodcat_qtybreak",         precision: 18, scale: 6,                 null: false
    t.decimal "ipsprodcat_discntprcnt",      precision: 10, scale: 6,                 null: false
    t.decimal "ipsprodcat_fixedamtdiscount", precision: 16, scale: 4, default: "0.0", null: false
  end

  create_table "item", primary_key: "item_id", id: :integer, default: -> { "nextval(('item_item_id_seq'::text)::regclass)" }, force: :cascade, comment: "Item information" do |t|
    t.text    "item_number",                                                             null: false
    t.text    "item_descrip1",                                                           null: false
    t.text    "item_descrip2",                                                           null: false
    t.integer "item_classcode_id",                                                       null: false
    t.boolean "item_picklist",                                           default: true,  null: false
    t.text    "item_comments"
    t.boolean "item_sold",                                                               null: false
    t.boolean "item_fractional",                                                         null: false
    t.boolean "item_active",                                                             null: false
    t.string  "item_type",            limit: 1,                          default: "R",   null: false
    t.decimal "item_prodweight",                precision: 16, scale: 2, default: "0.0", null: false
    t.decimal "item_packweight",                precision: 16, scale: 2, default: "0.0", null: false
    t.integer "item_prodcat_id",                                                         null: false
    t.boolean "item_exclusive",                                          default: false, null: false
    t.decimal "item_listprice",                 precision: 16, scale: 4,                 null: false
    t.boolean "item_config",                                             default: false
    t.text    "item_extdescrip"
    t.text    "item_upccode"
    t.decimal "item_maxcost",                   precision: 16, scale: 6, default: "0.0", null: false, comment: "Maximum cost for item.  Used to constrain purchase order price."
    t.integer "item_inv_uom_id",                                                         null: false
    t.integer "item_price_uom_id",                                                       null: false
    t.integer "item_warrdays",                                           default: 0
    t.integer "item_freightclass_id"
    t.boolean "item_tax_recoverable",                                    default: false, null: false
    t.decimal "item_listcost",                  precision: 16, scale: 6, default: "0.0", null: false, comment: "List cost for item.  Basis for markup pricing."
    t.index ["item_classcode_id"], name: "item_classcode_id", using: :btree
    t.index ["item_number"], name: "item_item_number_key", unique: true, using: :btree
    t.index ["item_number"], name: "item_number_idx", unique: true, using: :btree
    t.index ["item_prodcat_id"], name: "item_prodcat_id_idx", using: :btree
    t.index ["item_upccode"], name: "item_upccode_idx", using: :btree
  end

  create_table "itemalias", primary_key: "itemalias_id", id: :integer, default: -> { "nextval(('\"itemalias_itemalias_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Item Alias information" do |t|
    t.integer "itemalias_item_id",    null: false
    t.text    "itemalias_number",     null: false
    t.text    "itemalias_comments"
    t.boolean "itemalias_usedescrip", null: false
    t.text    "itemalias_descrip1"
    t.text    "itemalias_descrip2"
    t.integer "itemalias_crmacct_id",              comment: "Associated crmacct for item alias."
    t.index ["itemalias_item_id", "itemalias_number"], name: "itemalias_itemalias_item_id_key", unique: true, using: :btree
  end

  create_table "itemcost", primary_key: "itemcost_id", id: :integer, default: -> { "nextval(('itemcost_itemcost_id_seq'::text)::regclass)" }, force: :cascade, comment: "Item Cost information" do |t|
    t.integer "itemcost_item_id",                                                              null: false
    t.integer "itemcost_costelem_id",                                                          null: false
    t.boolean "itemcost_lowlevel",                             default: false,                 null: false
    t.decimal "itemcost_stdcost",     precision: 16, scale: 6, default: "0.0",                 null: false
    t.date    "itemcost_posted"
    t.decimal "itemcost_actcost",     precision: 16, scale: 6, default: "0.0",                 null: false
    t.date    "itemcost_updated"
    t.integer "itemcost_curr_id",                              default: -> { "basecurrid()" }, null: false
    t.index ["itemcost_item_id", "itemcost_costelem_id", "itemcost_lowlevel"], name: "itemcost_master_idx", unique: true, using: :btree
    t.index ["itemcost_item_id"], name: "itemcost_item_id_key", using: :btree
  end

  create_table "itemgrp", primary_key: "itemgrp_id", id: :integer, default: -> { "nextval(('\"itemgrp_itemgrp_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Item Group information" do |t|
    t.text    "itemgrp_name",                    null: false
    t.text    "itemgrp_descrip"
    t.boolean "itemgrp_catalog", default: false, null: false
    t.index ["itemgrp_name"], name: "itemgrp_itemgrp_name_key", unique: true, using: :btree
  end

  create_table "itemgrpitem", primary_key: "itemgrpitem_id", id: :integer, default: -> { "nextval(('\"itemgrpitem_itemgrpitem_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Item Group Item information" do |t|
    t.integer "itemgrpitem_itemgrp_id"
    t.integer "itemgrpitem_item_id"
    t.string  "itemgrpitem_item_type",  limit: 1, default: "I", null: false
    t.index ["itemgrpitem_itemgrp_id", "itemgrpitem_item_id", "itemgrpitem_item_type"], name: "itemgrpitem_unique_key", unique: true, using: :btree
  end

  create_table "itemloc", primary_key: "itemloc_id", id: :integer, default: -> { "nextval(('\"itemloc_itemloc_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Detailed Location information for Lot/Serial and Multiple Location Control (MLC) Items" do |t|
    t.integer "itemloc_itemsite_id",                          null: false
    t.integer "itemloc_location_id",                          null: false
    t.decimal "itemloc_qty",         precision: 18, scale: 6, null: false
    t.date    "itemloc_expiration",                           null: false
    t.boolean "itemloc_consolflag"
    t.integer "itemloc_ls_id"
    t.date    "itemloc_warrpurc"
    t.index ["itemloc_itemsite_id"], name: "itemloc_itemsite_idx", using: :btree
    t.index ["itemloc_location_id"], name: "itemloc_location_idx", using: :btree
  end

  create_table "itemlocdist", primary_key: "itemlocdist_id", id: :integer, default: -> { "nextval(('\"itemlocdist_itemlocdist_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Temporary table for storing information about Inventory distributions involving Lot/Serial and Multiple Location Control (MLC) Items" do |t|
    t.integer "itemlocdist_itemlocdist_id"
    t.string  "itemlocdist_source_type",    limit: 1
    t.integer "itemlocdist_source_id"
    t.decimal "itemlocdist_qty",                      precision: 18, scale: 6
    t.integer "itemlocdist_series"
    t.integer "itemlocdist_invhist_id"
    t.integer "itemlocdist_itemsite_id"
    t.boolean "itemlocdist_reqlotserial",                                      default: false
    t.boolean "itemlocdist_flush",                                             default: false
    t.date    "itemlocdist_expiration"
    t.boolean "itemlocdist_distlotserial"
    t.date    "itemlocdist_warranty"
    t.integer "itemlocdist_ls_id"
    t.text    "itemlocdist_order_type"
    t.integer "itemlocdist_order_id"
  end

  create_table "itemlocpost", primary_key: "itemlocpost_id", force: :cascade, comment: "Temporary table for storing information about Inventory distribution G/L postings involving Lot/Serial and Multiple Location Control (MLC) Items" do |t|
    t.integer "itemlocpost_itemlocseries"
    t.integer "itemlocpost_glseq"
  end

  create_table "itemsite", primary_key: "itemsite_id", id: :integer, default: -> { "nextval(('itemsite_itemsite_id_seq'::text)::regclass)" }, force: :cascade, comment: "Item Site information" do |t|
    t.integer "itemsite_item_id",                                                               null: false
    t.integer "itemsite_warehous_id"
    t.decimal "itemsite_qtyonhand",                    precision: 18, scale: 6,                 null: false
    t.decimal "itemsite_reorderlevel",                 precision: 18, scale: 6,                 null: false
    t.decimal "itemsite_ordertoqty",                   precision: 18, scale: 6,                 null: false
    t.integer "itemsite_cyclecountfreq",                                                        null: false
    t.date    "itemsite_datelastcount"
    t.date    "itemsite_datelastused"
    t.boolean "itemsite_loccntrl",                                                              null: false
    t.decimal "itemsite_safetystock",                  precision: 18, scale: 6,                 null: false
    t.decimal "itemsite_minordqty",                    precision: 18, scale: 6,                 null: false
    t.decimal "itemsite_multordqty",                   precision: 18, scale: 6,                 null: false
    t.integer "itemsite_leadtime",                                                              null: false
    t.string  "itemsite_abcclass",           limit: 1
    t.string  "itemsite_issuemethod",        limit: 1
    t.string  "itemsite_controlmethod",      limit: 1
    t.boolean "itemsite_active",                                                                null: false
    t.integer "itemsite_plancode_id",                                                           null: false
    t.integer "itemsite_costcat_id",                                                            null: false
    t.integer "itemsite_eventfence",                                                            null: false
    t.boolean "itemsite_sold",                                                                  null: false
    t.boolean "itemsite_stocked",                                                               null: false
    t.boolean "itemsite_freeze",                                                default: false, null: false
    t.integer "itemsite_location_id",                                                           null: false
    t.boolean "itemsite_useparams",                                                             null: false
    t.boolean "itemsite_useparamsmanual",                                                       null: false
    t.integer "itemsite_soldranking",                                           default: 1
    t.boolean "itemsite_createpr"
    t.text    "itemsite_location"
    t.text    "itemsite_location_comments"
    t.text    "itemsite_notes"
    t.boolean "itemsite_perishable",                                                            null: false
    t.boolean "itemsite_autoabcclass",                                                          null: false
    t.integer "itemsite_ordergroup",                                            default: 1,     null: false
    t.boolean "itemsite_disallowblankwip",                                      default: false, null: false
    t.decimal "itemsite_maxordqty",                    precision: 18, scale: 6, default: "0.0", null: false
    t.integer "itemsite_mps_timefence",                                         default: 0,     null: false
    t.boolean "itemsite_createwo",                                              default: false, null: false
    t.boolean "itemsite_warrpurc",                                              default: false, null: false
    t.boolean "itemsite_autoreg",                                               default: false
    t.string  "itemsite_costmethod",         limit: 1,                                          null: false
    t.decimal "itemsite_value",                        precision: 12, scale: 2,                 null: false
    t.boolean "itemsite_ordergroup_first",                                      default: false, null: false
    t.integer "itemsite_supply_itemsite_id"
    t.string  "itemsite_planning_type",      limit: 1,                          default: "M",   null: false
    t.boolean "itemsite_wosupply",                                              default: false, null: false
    t.boolean "itemsite_posupply",                                              default: false, null: false
    t.integer "itemsite_lsseq_id",                                                                           comment: "Foreign key reference for automatic lot/serial numbering"
    t.string  "itemsite_cosdefault",         limit: 1
    t.boolean "itemsite_createsopr",                                            default: false,              comment: "Used to flag Sales items that create P/Rs"
    t.boolean "itemsite_createsopo",                                            default: false,              comment: "Used to flag Sales items that create P/Os"
    t.boolean "itemsite_dropship",                                              default: false,              comment: "Used to flag Sales items to drop ship"
    t.integer "itemsite_recvlocation_id",                                       default: -1,    null: false
    t.integer "itemsite_issuelocation_id",                                      default: -1,    null: false
    t.boolean "itemsite_location_dist",                                         default: false, null: false
    t.boolean "itemsite_recvlocation_dist",                                     default: false, null: false
    t.boolean "itemsite_issuelocation_dist",                                    default: false, null: false
    t.index ["itemsite_active"], name: "itemsite_active_key", using: :btree
    t.index ["itemsite_item_id", "itemsite_warehous_id"], name: "itemsite_item_warehous_id_key", unique: true, using: :btree
    t.index ["itemsite_item_id"], name: "itemsite_item_id_key", using: :btree
    t.index ["itemsite_plancode_id"], name: "itemsite_plancode_id_key", using: :btree
    t.index ["itemsite_warehous_id"], name: "itemsite_warehous_id_key", using: :btree
  end

  create_table "itemsrc", primary_key: "itemsrc_id", id: :integer, default: -> { "nextval(('\"itemsrc_itemsrc_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Item Source information" do |t|
    t.integer "itemsrc_item_id",                                                                       null: false
    t.integer "itemsrc_vend_id",                                                                       null: false
    t.text    "itemsrc_vend_item_number"
    t.text    "itemsrc_vend_item_descrip"
    t.text    "itemsrc_comments"
    t.text    "itemsrc_vend_uom",                                                                      null: false
    t.decimal "itemsrc_invvendoruomratio",  precision: 20, scale: 10,                                  null: false
    t.decimal "itemsrc_minordqty",          precision: 18, scale: 6,                                   null: false
    t.decimal "itemsrc_multordqty",         precision: 18, scale: 6,                                   null: false
    t.integer "itemsrc_leadtime",                                                                      null: false
    t.integer "itemsrc_ranking",                                                                       null: false
    t.boolean "itemsrc_active",                                                                        null: false
    t.text    "itemsrc_manuf_name",                                   default: "",                     null: false
    t.text    "itemsrc_manuf_item_number",                            default: "",                     null: false
    t.text    "itemsrc_manuf_item_descrip"
    t.boolean "itemsrc_default"
    t.text    "itemsrc_upccode"
    t.date    "itemsrc_effective",                                    default: -> { "startoftime()" }, null: false, comment: "Effective date for item source.  Constraint for overlap."
    t.date    "itemsrc_expires",                                      default: -> { "endoftime()" },   null: false, comment: "Expiration date for item source.  Constraint for overlap."
    t.integer "itemsrc_contrct_id",                                                                                 comment: "Associated contract for item source.  Inherits effective, expiration dates."
    t.decimal "itemsrc_contrct_max",        precision: 18, scale: 6,  default: "0.0",                  null: false
    t.decimal "itemsrc_contrct_min",        precision: 18, scale: 6,  default: "0.0",                  null: false
    t.index ["itemsrc_vend_id", "itemsrc_item_id", "itemsrc_effective", "itemsrc_expires", "itemsrc_vend_item_number", "itemsrc_manuf_name", "itemsrc_manuf_item_number", "itemsrc_contrct_id"], name: "itemsrc_itemsrc_vend_id_key", unique: true, using: :btree
    t.index ["itemsrc_vend_id"], name: "itemsrc_vend_id_idx", using: :btree
  end

  create_table "itemsrcp", primary_key: "itemsrcp_id", id: :integer, default: -> { "nextval(('itemsrcp_itemsrcp_id_seq'::text)::regclass)" }, force: :cascade, comment: "Item Source Price information" do |t|
    t.integer "itemsrcp_itemsrc_id",                                                                          null: false
    t.decimal "itemsrcp_qtybreak",                   precision: 18, scale: 6,                                 null: false
    t.decimal "itemsrcp_price",                      precision: 16, scale: 6
    t.date    "itemsrcp_updated"
    t.integer "itemsrcp_curr_id",                                             default: -> { "basecurrid()" }, null: false
    t.boolean "itemsrcp_dropship",                                            default: false,                 null: false, comment: "Used to determine if item source price applies only to drop ship purchase orders."
    t.integer "itemsrcp_warehous_id",                                         default: -1,                    null: false, comment: "Used to determine if item source price applies only to specific site on purchase orders."
    t.string  "itemsrcp_type",             limit: 1,                                                          null: false, comment: "Pricing type for item source price.  Valid values are N-nominal and D-discount."
    t.decimal "itemsrcp_discntprcnt",                precision: 16, scale: 6,                                              comment: "Discount percent for item source price."
    t.decimal "itemsrcp_fixedamtdiscount",           precision: 16, scale: 6,                                              comment: "Fixed amount discount for item source price."
    t.index ["itemsrcp_itemsrc_id", "itemsrcp_warehous_id", "itemsrcp_dropship", "itemsrcp_qtybreak"], name: "itemsrcp_itemsrcp_itemsrc_id_key", unique: true, using: :btree
    t.index ["itemsrcp_itemsrc_id"], name: "itemsrcp_itemsrc_id_key", using: :btree
  end

  create_table "itemsub", primary_key: "itemsub_id", id: :integer, default: -> { "nextval(('itemsub_itemsub_id_seq'::text)::regclass)" }, force: :cascade, comment: "Item Substitutes information" do |t|
    t.integer "itemsub_parent_item_id",                           null: false
    t.integer "itemsub_sub_item_id",                              null: false
    t.decimal "itemsub_uomratio",       precision: 20, scale: 10, null: false
    t.integer "itemsub_rank",                                     null: false
    t.index ["itemsub_parent_item_id", "itemsub_sub_item_id"], name: "itemsub_itemsub_parent_item_id_key", unique: true, using: :btree
    t.index ["itemsub_parent_item_id"], name: "itemsub_parent_item_id_key", using: :btree
    t.index ["itemsub_sub_item_id"], name: "itemsub_sub_item_id_key", using: :btree
  end

  create_table "itemtax", primary_key: "itemtax_id", force: :cascade, comment: "This table associates tax types in a specified tax authority for the given item." do |t|
    t.integer "itemtax_item_id",    null: false
    t.integer "itemtax_taxtype_id", null: false
    t.integer "itemtax_taxzone_id"
  end

  create_table "itemtrans", primary_key: "itemtrans_id", force: :cascade, comment: "Item Transformation information" do |t|
    t.integer "itemtrans_source_item_id"
    t.integer "itemtrans_target_item_id"
    t.index ["itemtrans_source_item_id", "itemtrans_target_item_id"], name: "itemtrans_itemtrans_source_item_id_key", unique: true, using: :btree
  end

  create_table "itemuom", primary_key: "itemuom_id", force: :cascade, comment: "A UOM type relation for a specific conversion." do |t|
    t.integer "itemuom_itemuomconv_id", null: false
    t.integer "itemuom_uomtype_id",     null: false
  end

  create_table "itemuomconv", primary_key: "itemuomconv_id", force: :cascade, comment: "UOM conversion information. From Unit to To Unit with a value per." do |t|
    t.integer "itemuomconv_item_id",                                               null: false
    t.integer "itemuomconv_from_uom_id",                                           null: false
    t.decimal "itemuomconv_from_value",  precision: 20, scale: 10,                 null: false
    t.integer "itemuomconv_to_uom_id",                                             null: false
    t.decimal "itemuomconv_to_value",    precision: 20, scale: 10,                 null: false
    t.boolean "itemuomconv_fractional",                            default: false, null: false
    t.boolean "itemuomconv_active",                                default: true,  null: false, comment: "Item UOM conversion active/inactive"
  end

  create_table "jrnluse", primary_key: "jrnluse_id", id: :integer, default: -> { "nextval(('\"jrnluse_jrnluse_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Journal entry and use information" do |t|
    t.datetime "jrnluse_date"
    t.integer  "jrnluse_number"
    t.text     "jrnluse_use"
  end

  create_table "labeldef", primary_key: "labeldef_id", force: :cascade do |t|
    t.text    "labeldef_name",           null: false
    t.text    "labeldef_papersize",      null: false
    t.integer "labeldef_columns",        null: false
    t.integer "labeldef_rows",           null: false
    t.integer "labeldef_width",          null: false
    t.integer "labeldef_height",         null: false
    t.integer "labeldef_start_offset_x", null: false
    t.integer "labeldef_start_offset_y", null: false
    t.integer "labeldef_horizontal_gap", null: false
    t.integer "labeldef_vertical_gap",   null: false
  end

  create_table "labelform", primary_key: "labelform_id", id: :integer, default: -> { "nextval(('\"labelform_labelform_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Label Form information" do |t|
    t.text    "labelform_name",        null: false
    t.integer "labelform_report_id",                comment: "Obsolete -- reference labelform_report_name instead."
    t.integer "labelform_perpage"
    t.text    "labelform_report_name"
    t.index ["labelform_name"], name: "labelform_labelform_name_key", unique: true, using: :btree
  end

  create_table "lang", primary_key: "lang_id", force: :cascade, comment: "Table mapping ISO 639-1 and 639-2 language codes to Qt's enum QLocale::Language integer values. See http://www.loc.gov/standards/iso639-2/php/code_list.php and the QLocale documentation.." do |t|
    t.integer "lang_qt_number"
    t.text    "lang_abbr3",                  comment: "ISO 639-2 code for language. Where there is a choice between bibliographic (B) and terminology (T) usage, this value is the T code"
    t.text    "lang_abbr2",                  comment: "ISO 639-1 code for language"
    t.text    "lang_name",      null: false, comment: "Name of a human language, taken from the ISO 639-2 documentation"
  end

  create_table "locale", primary_key: "locale_id", id: :integer, default: -> { "nextval(('locale_locale_id_seq'::text)::regclass)" }, force: :cascade, comment: "The locale table holds information required to show data to the user in a localized format. Colors are either names documented by the WWW Consortium or RGB colors. Format for RGB colors is #RGB, #RRGGBB, or #RRRGGGBBB, where the letters R, G, and B stand for hexidecimal digits." do |t|
    t.text    "locale_code",                          null: false
    t.text    "locale_descrip"
    t.text    "locale_lang_file",                                  comment: "Deprecated"
    t.text    "locale_dateformat",                                 comment: "Deprecated"
    t.text    "locale_currformat",                                 comment: "Deprecated"
    t.text    "locale_qtyformat",                                  comment: "Deprecated"
    t.text    "locale_comments"
    t.text    "locale_qtyperformat",                               comment: "Deprecated"
    t.text    "locale_salespriceformat",                           comment: "Deprecated"
    t.text    "locale_extpriceformat",                             comment: "Deprecated"
    t.text    "locale_timeformat",                                 comment: "Deprecated"
    t.text    "locale_timestampformat",                            comment: "Deprecated"
    t.text    "local_costformat",                                  comment: "Deprecated"
    t.text    "locale_costformat",                                 comment: "Deprecated"
    t.text    "locale_purchpriceformat",                           comment: "Deprecated"
    t.text    "locale_uomratioformat",                             comment: "Deprecated"
    t.text    "locale_intervalformat",                             comment: "Deprecated"
    t.integer "locale_lang_id"
    t.integer "locale_country_id"
    t.text    "locale_error_color",                                comment: "Color to use to mark data that require immediate attention."
    t.text    "locale_warning_color",                              comment: "Color to use to mark data that require attention soon."
    t.text    "locale_emphasis_color",                             comment: "Color to use to mark data that need to stand out but are not in error."
    t.text    "locale_altemphasis_color",                          comment: "Color to use to mark data that need to stand out and be differentiated from other emphasized data."
    t.text    "locale_expired_color",                              comment: "Color to use to mark data that are no longer current."
    t.text    "locale_future_color",                               comment: "Color to use to mark data that will not be effective until some point in the future."
    t.integer "locale_curr_scale",                                 comment: "Number of decimal places to show when displaying Currency values."
    t.integer "locale_salesprice_scale",                           comment: "Number of decimal places to show when displaying Sales Prices."
    t.integer "locale_purchprice_scale",                           comment: "Number of decimal places to show when displaying Purchase Prices."
    t.integer "locale_extprice_scale",                             comment: "Number of decimal places to show when displaying Extended Prices."
    t.integer "locale_cost_scale",                                 comment: "Number of decimal places to show when displaying Costs."
    t.integer "locale_qty_scale",                                  comment: "Number of decimal places to show when displaying Quantities."
    t.integer "locale_qtyper_scale",                               comment: "Number of decimal places to show when displaying Quantities Per."
    t.integer "locale_uomratio_scale",                             comment: "Number of decimal places to show when displaying UOM Ratios."
    t.integer "locale_percent_scale",     default: 2
    t.integer "locale_weight_scale",      default: 2, null: false
    t.index ["locale_code"], name: "locale_locale_code_key", unique: true, using: :btree
  end

  create_table "location", primary_key: "location_id", id: :integer, default: -> { "nextval(('location_location_id_seq'::text)::regclass)" }, force: :cascade, comment: "Warehouse Location information" do |t|
    t.integer "location_warehous_id", null: false
    t.text    "location_name",        null: false
    t.text    "location_descrip"
    t.boolean "location_restrict"
    t.boolean "location_netable"
    t.integer "location_whsezone_id"
    t.text    "location_aisle"
    t.text    "location_rack"
    t.text    "location_bin"
    t.text    "location_formatname"
    t.boolean "location_usable"
    t.index ["location_formatname"], name: "location_location_formatname_idx", using: :btree
    t.index ["location_warehous_id"], name: "location_warehous_idx", using: :btree
  end

  create_table "locitem", primary_key: "locitem_id", id: :integer, default: -> { "nextval(('\"locitem_locitem_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Restricted Warehouse Location Allowable Items information" do |t|
    t.integer "locitem_location_id"
    t.integer "locitem_item_id"
  end

  create_table "ls", primary_key: "ls_id", force: :cascade, comment: "Lot and Serial numbers table." do |t|
    t.integer "ls_item_id"
    t.text    "ls_number",  null: false
    t.text    "ls_notes"
    t.index ["ls_item_id", "ls_number"], name: "ls_ls_item_id_key", unique: true, using: :btree
    t.index ["ls_number"], name: "ls_ls_number_idx", using: :btree
  end

  create_table "lsdetail", primary_key: "lsdetail_id", force: :cascade, comment: "Lot/Serial history" do |t|
    t.integer  "lsdetail_itemsite_id"
    t.datetime "lsdetail_created"
    t.string   "lsdetail_source_type",   limit: 2
    t.integer  "lsdetail_source_id"
    t.text     "lsdetail_source_number"
    t.integer  "lsdetail_ls_id"
    t.decimal  "lsdetail_qtytoassign",             precision: 18, scale: 6, default: "0.0"
    t.date     "lsdetail_expiration",                                                       comment: "Lot/Serial Expiration Date"
    t.date     "lsdetail_warrpurc",                                                         comment: "Lot/Serial Warranty Date"
  end

  create_table "lsreg", primary_key: "lsreg_id", force: :cascade, comment: "Lot/Serial Warranty Registration" do |t|
    t.text    "lsreg_number"
    t.integer "lsreg_crmacct_id",                                           null: false
    t.integer "lsreg_regtype_id",                                           null: false
    t.date    "lsreg_regdate",                                              null: false
    t.date    "lsreg_solddate",                                             null: false
    t.date    "lsreg_expiredate",                                           null: false
    t.integer "lsreg_ls_id",                                                null: false
    t.integer "lsreg_cntct_id",                                             null: false
    t.integer "lsreg_cohead_id"
    t.integer "lsreg_shiphead_id"
    t.text    "lsreg_notes"
    t.decimal "lsreg_qty",         precision: 18, scale: 6, default: "0.0"
    t.index ["lsreg_number"], name: "lsreg_lsreg_number_key", unique: true, using: :btree
  end

  create_table "lsseq", primary_key: "lsseq_id", force: :cascade, comment: "Lot/Serial sequence for automatically created lot/serial numbers" do |t|
    t.text    "lsseq_number",               null: false, comment: "Sequence number"
    t.text    "lsseq_descrip",                           comment: "Description"
    t.integer "lsseq_seqlen",  default: 5,               comment: "Minimum length of sequence number.  Smaller numbers are padded with zeros."
    t.text    "lsseq_prefix",  default: "",              comment: "A text prefix for generated lot/serial numbers."
    t.text    "lsseq_suffix",  default: "",              comment: "A text suffix for generated lot/serial numbers."
    t.index ["lsseq_number"], name: "lsseq_lsseq_number_key", unique: true, using: :btree
  end

  create_table "lswarr", primary_key: "lswarr_id", force: :cascade, comment: "Lot/Serial Warranty Expiration Dates" do |t|
    t.integer "lswarr_crmacct_id",                                          null: false
    t.integer "lswarr_regtype_id",                                          null: false
    t.date    "lswarr_start",                                               null: false
    t.date    "lswarr_expiration",                                          null: false
    t.text    "lswarr_username",    default: -> { "geteffectivextuser()" }
    t.time    "lswarr_lastupdated"
  end

  create_table "metasql", primary_key: "metasql_id", force: :cascade, comment: "MetaSQL Table" do |t|
    t.text    "metasql_group"
    t.text    "metasql_name"
    t.text    "metasql_notes"
    t.text    "metasql_query"
    t.text    "metasql_lastuser"
    t.date    "metasql_lastupdate"
    t.integer "metasql_grade",      default: 0, null: false
    t.index ["metasql_group", "metasql_name", "metasql_grade"], name: "metasql_metasql_group_name_grade_key", unique: true, using: :btree
  end

  create_table "metric", primary_key: "metric_id", id: :integer, default: -> { "nextval(('metric_metric_id_seq'::text)::regclass)" }, force: :cascade, comment: "Application-wide settings information" do |t|
    t.text "metric_name",   null: false
    t.text "metric_value"
    t.text "metric_module"
    t.index ["metric_name"], name: "metric_metric_name_key", unique: true, using: :btree
  end

  create_table "metricenc", primary_key: "metricenc_id", force: :cascade, comment: "Application-wide settings information encrypted data" do |t|
    t.text   "metricenc_name",   null: false
    t.binary "metricenc_value"
    t.text   "metricenc_module"
    t.index ["metricenc_name"], name: "metricenc_metricenc_name_key", unique: true, using: :btree
  end

  create_table "mpsmrpwork", primary_key: "mpsmrpwork_id", force: :cascade, comment: "Temporary table for storing information requested by Material Requirements Planning (MRP) and Master Production Scheduling (MPS) displays and reports" do |t|
    t.integer "mpsmrpwork_set_id"
    t.integer "mpsmrpwork_order"
    t.date    "mpsmrpwork_startdate"
    t.date    "mpsmrpwork_enddate"
    t.decimal "mpsmrpwork_qoh",                 precision: 20, scale: 8
    t.decimal "mpsmrpwork_allocations",         precision: 20, scale: 8
    t.decimal "mpsmrpwork_orders",              precision: 20, scale: 8
    t.decimal "mpsmrpwork_availability",        precision: 20, scale: 8
    t.decimal "mpsmrpwork_planned",             precision: 20, scale: 8
    t.decimal "mpsmrpwork_plannedavailability", precision: 20, scale: 8
    t.decimal "mpsmrpwork_firmed",              precision: 20, scale: 8
    t.decimal "mpsmrpwork_firmedavailability",  precision: 20, scale: 8
    t.decimal "mpsmrpwork_available",           precision: 20, scale: 8
  end

  create_table "mrghist", primary_key: ["mrghist_cntct_id", "mrghist_table", "mrghist_pkey_col", "mrghist_pkey_id", "mrghist_cntct_col"], force: :cascade do |t|
    t.integer "mrghist_cntct_id",  null: false
    t.text    "mrghist_table",     null: false
    t.text    "mrghist_pkey_col",  null: false
    t.integer "mrghist_pkey_id",   null: false
    t.text    "mrghist_cntct_col", null: false
  end

  create_table "mrgundo", id: false, force: :cascade, comment: "This table keeps track of the original values of changes made while merging two records. It is a generalization of mrghist and trgthist, which are specific to merging contacts. The schema, table, and pkey_id columns uniquely identify the record that was changed while the _base_ columns identify the merge target. The _base_ columns are required to allow finding all of the records that pertain to a particular merge (e.g. find changes to the comment table that pertain to a crmacct merge)." do |t|
    t.text    "mrgundo_base_schema", comment: "The schema in which the merge target resides."
    t.text    "mrgundo_base_table",  comment: "The table in which the merge target resides."
    t.integer "mrgundo_base_id",     comment: "The internal id of the merge target record."
    t.text    "mrgundo_schema",      comment: "The name of the schema in which the modified table resides."
    t.text    "mrgundo_table",       comment: "The name of the table that was modified during a merge."
    t.text    "mrgundo_pkey_col",    comment: "The name of the primary key column in the modified table. This could be derived during the undo processing but it is simpler just to store it during the merge."
    t.integer "mrgundo_pkey_id",     comment: "The primary key of the modified record."
    t.text    "mrgundo_col",         comment: "The column that was modified."
    t.text    "mrgundo_value",       comment: "The value of the column before the change."
    t.text    "mrgundo_type",        comment: "The data type of the modified column. This could be derived during the undo processing but it is simpler just to store it during the merge."
    t.index ["mrgundo_schema", "mrgundo_table", "mrgundo_pkey_col", "mrgundo_pkey_id", "mrgundo_col"], name: "mrgundo_mrgundo_schema_key", unique: true, using: :btree
  end

  create_table "msg", primary_key: "msg_id", id: :integer, default: -> { "nextval(('\"msg_msg_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "System Message information" do |t|
    t.datetime "msg_posted"
    t.datetime "msg_scheduled"
    t.text     "msg_text"
    t.datetime "msg_expires"
    t.text     "msg_username"
  end

  create_table "msguser", primary_key: "msguser_id", id: :integer, default: -> { "nextval(('\"msguser_msguser_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "System Message user information" do |t|
    t.integer  "msguser_msg_id"
    t.datetime "msguser_viewed"
    t.text     "msguser_username"
  end

  create_table "obsolete_tax", primary_key: "tax_id", id: :integer, default: -> { "nextval(('\"tax_tax_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Tax information. Obsolete table structure." do |t|
    t.text    "tax_code"
    t.text    "tax_descrip"
    t.decimal "tax_ratea",           precision: 8, scale: 4
    t.integer "tax_sales_accnt_id"
    t.boolean "tax_freight",                                 default: false, null: false, comment: "Deprecated in 2.1 and moved to taxsel table where taxtype is the system defined Freight."
    t.boolean "tax_cumulative",                              default: false, null: false
    t.decimal "tax_rateb",           precision: 8, scale: 4
    t.integer "tax_salesb_accnt_id"
    t.decimal "tax_ratec",           precision: 8, scale: 4
    t.integer "tax_salesc_accnt_id"
  end

  create_table "ophead", primary_key: "ophead_id", force: :cascade, comment: "Opportunity header." do |t|
    t.text    "ophead_name",                                                      null: false
    t.integer "ophead_crmacct_id"
    t.text    "ophead_owner_username"
    t.integer "ophead_opstage_id"
    t.integer "ophead_opsource_id"
    t.integer "ophead_optype_id"
    t.integer "ophead_probability_prcnt"
    t.decimal "ophead_amount",            precision: 20, scale: 4
    t.date    "ophead_target_date"
    t.date    "ophead_actual_date"
    t.text    "ophead_notes"
    t.integer "ophead_curr_id"
    t.boolean "ophead_active",                                     default: true
    t.integer "ophead_cntct_id"
    t.text    "ophead_username"
    t.date    "ophead_start_date"
    t.date    "ophead_assigned_date"
    t.integer "ophead_priority_id"
    t.text    "ophead_number",                                                    null: false
    t.index ["ophead_number"], name: "ophead_ophead_number_key", unique: true, using: :btree
  end

  create_table "opsource", primary_key: "opsource_id", force: :cascade, comment: "Opportunity Lead Source values." do |t|
    t.text "opsource_name",    null: false
    t.text "opsource_descrip"
    t.index ["opsource_name"], name: "opsource_opsource_name_key", unique: true, using: :btree
  end

  create_table "opstage", primary_key: "opstage_id", force: :cascade, comment: "Opportunity stage values." do |t|
    t.text    "opstage_name",                       null: false
    t.text    "opstage_descrip"
    t.integer "opstage_order",      default: 0,     null: false
    t.boolean "opstage_opinactive", default: false
    t.index ["opstage_name"], name: "opstage_opstage_name_key", unique: true, using: :btree
  end

  create_table "optype", primary_key: "optype_id", force: :cascade, comment: "Opportunity Type values." do |t|
    t.text "optype_name",    null: false
    t.text "optype_descrip"
    t.index ["optype_name"], name: "optype_optype_name_key", unique: true, using: :btree
  end

# Could not dump table "orderseq" because of following StandardError
#   Unknown type 'seqiss' for column 'orderseq_seqiss'

  create_table "pack", primary_key: "pack_id", force: :cascade, comment: "Temporary table for storing information about Orders added to the Packing List Batch" do |t|
    t.integer "pack_head_id",                     null: false
    t.text    "pack_head_type",                   null: false
    t.integer "pack_shiphead_id"
    t.boolean "pack_printed",     default: false, null: false
  end

  create_table "payaropen", primary_key: ["payaropen_ccpay_id", "payaropen_aropen_id"], force: :cascade, comment: "Credit Card payment to credit memo join table" do |t|
    t.integer "payaropen_ccpay_id",                                                           null: false
    t.integer "payaropen_aropen_id",                                                          null: false
    t.decimal "payaropen_amount",    precision: 20, scale: 2, default: "0.0",                 null: false
    t.integer "payaropen_curr_id",                            default: -> { "basecurrid()" }
    t.index ["payaropen_aropen_id"], name: "payaropen_aropen_id_idx", using: :btree
    t.index ["payaropen_ccpay_id"], name: "payaropen_ccpay_id_idx", using: :btree
  end

  create_table "payco", primary_key: "payco_id", force: :cascade, comment: "Credit Card payment to sales order join table" do |t|
    t.integer "payco_ccpay_id",                                                           null: false
    t.integer "payco_cohead_id",                                                          null: false
    t.decimal "payco_amount",    precision: 20, scale: 2, default: "0.0",                 null: false
    t.integer "payco_curr_id",                            default: -> { "basecurrid()" }
    t.index ["payco_ccpay_id", "payco_cohead_id"], name: "payco_unique_ccpay_id_cohead_id", unique: true, using: :btree
    t.index ["payco_ccpay_id"], name: "payco_ccpay_id_idx", using: :btree
    t.index ["payco_cohead_id"], name: "payco_cohead_id_idx", using: :btree
  end

  create_table "period", primary_key: "period_id", force: :cascade, comment: "Accounting Period information" do |t|
    t.date    "period_start"
    t.date    "period_end"
    t.boolean "period_closed"
    t.boolean "period_freeze"
    t.boolean "period_initial",       default: false
    t.text    "period_name"
    t.integer "period_yearperiod_id"
    t.integer "period_quarter"
    t.integer "period_number",                        null: false
  end

  create_table "pkgdep", primary_key: "pkgdep_id", force: :cascade, comment: "Package Dependencies list describing which packages are dependent on which other packages." do |t|
    t.integer "pkgdep_pkghead_id",        null: false, comment: "This is the internal ID of a package which requires at least one other package to be installed first to operate successfully"
    t.integer "pkgdep_parent_pkghead_id", null: false, comment: "This is the internal ID of a package which must be installed for the package pointed to by pkgdep_pkghead_id to operate successfully."
  end

  create_table "pkghead", primary_key: "pkghead_id", force: :cascade, comment: "Information about non-core Packages added to the database" do |t|
    t.text     "pkghead_name",                      null: false
    t.text     "pkghead_descrip"
    t.text     "pkghead_version",                   null: false
    t.text     "pkghead_developer",                 null: false
    t.text     "pkghead_notes"
    t.datetime "pkghead_created"
    t.datetime "pkghead_updated"
    t.boolean  "pkghead_indev",     default: false, null: false, comment: "Flag indicating whether the contents of this package may be modified in-place - this package is /in dev/elopment."
  end

  create_table "pkgitem", primary_key: "pkgitem_id", force: :cascade, comment: "Deprecated - the pkgitem table is no longer used to track package contents. It has been replaced by direct queries to the database schema and component tables. This table will be removed when all users have switched to Updater 2.2.0 or later." do |t|
    t.integer "pkgitem_pkghead_id"
    t.text    "pkgitem_type"
    t.integer "pkgitem_item_id",    null: false
    t.text    "pkgitem_name",       null: false
    t.text    "pkgitem_descrip"
    t.index ["pkgitem_pkghead_id", "pkgitem_type", "pkgitem_item_id"], name: "pkgitem_pkgitem_pkghead_id_key1", unique: true, using: :btree
    t.index ["pkgitem_pkghead_id", "pkgitem_type", "pkgitem_name"], name: "pkgitem_pkgitem_pkghead_id_key", unique: true, using: :btree
  end

  create_table "plancode", primary_key: "plancode_id", id: :integer, default: -> { "nextval(('plancode_plancode_id_seq'::text)::regclass)" }, force: :cascade, comment: "Planner Code information" do |t|
    t.text    "plancode_code",                      null: false
    t.text    "plancode_name"
    t.string  "plancode_mpsexplosion",    limit: 1
    t.boolean "plancode_consumefcst"
    t.boolean "plancode_mrpexcp_resched"
    t.boolean "plancode_mrpexcp_delete"
    t.index ["plancode_code"], name: "plancode_plancode_code_key", unique: true, using: :btree
  end

  create_table "planord", primary_key: "planord_id", force: :cascade, comment: "Temporary table for storing information about Planned Orders" do |t|
    t.string  "planord_type",               limit: 1
    t.integer "planord_itemsite_id"
    t.date    "planord_duedate"
    t.decimal "planord_qty",                          precision: 16, scale: 4
    t.boolean "planord_firm"
    t.text    "planord_comments"
    t.integer "planord_number"
    t.integer "planord_subnumber"
    t.date    "planord_startdate"
    t.integer "planord_planord_id"
    t.boolean "planord_mps",                                                   default: false, null: false
    t.integer "planord_pschitem_id"
    t.integer "planord_supply_itemsite_id"
    t.index ["planord_itemsite_id"], name: "planord_itemsite_id_key", using: :btree
    t.index ["planord_number", "planord_subnumber"], name: "planord_planord_number_key", unique: true, using: :btree
    t.index ["planord_startdate"], name: "planord_startdate_idx", using: :btree
  end

  create_table "planreq", primary_key: "planreq_id", force: :cascade, comment: "Temporary table for storing information about Planned Work Order Material Requirements from exploded Planned Work Orders" do |t|
    t.string  "planreq_source",          limit: 1
    t.integer "planreq_source_id"
    t.integer "planreq_itemsite_id"
    t.decimal "planreq_qty",                       precision: 16, scale: 4
    t.text    "planreq_notes"
    t.integer "planreq_planoper_seq_id",                                    comment: "The Operation Sequence Id"
    t.index ["planreq_itemsite_id"], name: "planreq_itemsite_id_key", using: :btree
    t.index ["planreq_source_id"], name: "planreq_source_id_key", using: :btree
  end

  create_table "pohead", primary_key: "pohead_id", id: :integer, default: -> { "nextval(('pohead_pohead_id_seq'::text)::regclass)" }, force: :cascade, comment: "Purchase Order header information" do |t|
    t.string  "pohead_status",                  limit: 1
    t.text    "pohead_number",                                                                                     null: false
    t.date    "pohead_orderdate"
    t.integer "pohead_vend_id"
    t.text    "pohead_fob"
    t.text    "pohead_shipvia"
    t.text    "pohead_comments"
    t.decimal "pohead_freight",                           precision: 16, scale: 2, default: "0.0"
    t.boolean "pohead_printed",                                                    default: false
    t.integer "pohead_terms_id"
    t.integer "pohead_warehous_id"
    t.integer "pohead_vendaddr_id"
    t.text    "pohead_agent_username"
    t.integer "pohead_curr_id",                                                    default: -> { "basecurrid()" }
    t.boolean "pohead_saved",                                                      default: true,                  null: false
    t.integer "pohead_taxzone_id"
    t.integer "pohead_taxtype_id"
    t.boolean "pohead_dropship",                                                   default: false
    t.integer "pohead_vend_cntct_id"
    t.text    "pohead_vend_cntct_honorific"
    t.text    "pohead_vend_cntct_first_name"
    t.text    "pohead_vend_cntct_middle"
    t.text    "pohead_vend_cntct_last_name"
    t.text    "pohead_vend_cntct_suffix"
    t.text    "pohead_vend_cntct_phone"
    t.text    "pohead_vend_cntct_title"
    t.text    "pohead_vend_cntct_fax"
    t.text    "pohead_vend_cntct_email"
    t.text    "pohead_vendaddress1"
    t.text    "pohead_vendaddress2"
    t.text    "pohead_vendaddress3"
    t.text    "pohead_vendcity"
    t.text    "pohead_vendstate"
    t.text    "pohead_vendzipcode"
    t.text    "pohead_vendcountry"
    t.integer "pohead_shipto_cntct_id"
    t.text    "pohead_shipto_cntct_honorific"
    t.text    "pohead_shipto_cntct_first_name"
    t.text    "pohead_shipto_cntct_middle"
    t.text    "pohead_shipto_cntct_last_name"
    t.text    "pohead_shipto_cntct_suffix"
    t.text    "pohead_shipto_cntct_phone"
    t.text    "pohead_shipto_cntct_title"
    t.text    "pohead_shipto_cntct_fax"
    t.text    "pohead_shipto_cntct_email"
    t.integer "pohead_shiptoaddress_id"
    t.text    "pohead_shiptoaddress1"
    t.text    "pohead_shiptoaddress2"
    t.text    "pohead_shiptoaddress3"
    t.text    "pohead_shiptocity"
    t.text    "pohead_shiptostate"
    t.text    "pohead_shiptozipcode"
    t.text    "pohead_shiptocountry"
    t.integer "pohead_cohead_id"
    t.date    "pohead_released"
    t.text    "pohead_shiptoname"
    t.index ["pohead_number"], name: "pohead_pohead_number_key", unique: true, using: :btree
    t.index ["pohead_status"], name: "pohead_pohead_status_idx", using: :btree
  end

  create_table "poitem", primary_key: "poitem_id", id: :integer, default: -> { "nextval(('poitem_poitem_id_seq'::text)::regclass)" }, force: :cascade, comment: "Purchase Order Line Item information" do |t|
    t.string  "poitem_status",             limit: 1
    t.integer "poitem_pohead_id"
    t.integer "poitem_linenumber"
    t.date    "poitem_duedate"
    t.integer "poitem_itemsite_id"
    t.text    "poitem_vend_item_descrip"
    t.text    "poitem_vend_uom"
    t.decimal "poitem_invvenduomratio",              precision: 20, scale: 10
    t.decimal "poitem_qty_ordered",                  precision: 18, scale: 6,                  null: false
    t.decimal "poitem_qty_received",                 precision: 18, scale: 6,  default: "0.0", null: false
    t.decimal "poitem_qty_returned",                 precision: 18, scale: 6,  default: "0.0", null: false
    t.decimal "poitem_qty_vouchered",                precision: 18, scale: 6,  default: "0.0", null: false
    t.decimal "poitem_unitprice",                    precision: 16, scale: 6
    t.text    "poitem_vend_item_number"
    t.text    "poitem_comments"
    t.decimal "poitem_qty_toreceive",                precision: 18, scale: 6
    t.integer "poitem_expcat_id"
    t.integer "poitem_itemsrc_id"
    t.decimal "poitem_freight",                      precision: 16, scale: 4,  default: "0.0", null: false
    t.decimal "poitem_freight_received",             precision: 16, scale: 4,  default: "0.0", null: false
    t.decimal "poitem_freight_vouchered",            precision: 16, scale: 4,  default: "0.0", null: false
    t.integer "poitem_prj_id"
    t.decimal "poitem_stdcost",                      precision: 16, scale: 6
    t.integer "poitem_bom_rev_id"
    t.integer "poitem_boo_rev_id"
    t.text    "poitem_manuf_name"
    t.text    "poitem_manuf_item_number"
    t.text    "poitem_manuf_item_descrip"
    t.integer "poitem_taxtype_id"
    t.boolean "poitem_tax_recoverable",                                        default: true,  null: false
    t.date    "poitem_rlsd_duedate"
    t.integer "poitem_order_id"
    t.string  "poitem_order_type",         limit: 1
    t.index ["poitem_itemsite_id", "poitem_status", "poitem_duedate"], name: "poitem_itemsite_status_duedate_key", using: :btree
    t.index ["poitem_itemsite_id"], name: "poitem_itemsite_id_key", using: :btree
    t.index ["poitem_pohead_id", "poitem_linenumber"], name: "poitem_poitem_pohead_id_key", unique: true, using: :btree
    t.index ["poitem_pohead_id"], name: "poitem_pohead_id_key", using: :btree
    t.index ["poitem_status"], name: "poitem_status_key", using: :btree
  end

  create_table "poreject", primary_key: "poreject_id", id: :integer, default: -> { "nextval(('\"poreject_poreject_id_seq\"'::text)::regclass)" }, comment: "This is the internal id of this poreject record", force: :cascade, comment: "The poreject table describes Purchase Order Items that were returned to Vendors." do |t|
    t.datetime "poreject_date",                                       comment: "This is the date and time the return was entered into the database"
    t.text     "poreject_ponumber",                                   comment: "This is the number of the original Purchase Order of this item"
    t.integer  "poreject_itemsite_id",                                comment: "This is the Item Site into which the item had been received"
    t.integer  "poreject_vend_id",                                    comment: "This is the Vendor from which the item had been purchased"
    t.text     "poreject_vend_item_number",                           comment: "This is the Vendor's item number for this item"
    t.text     "poreject_vend_item_descrip",                          comment: "This is the Vendor's description of this item"
    t.text     "poreject_vend_uom",                                   comment: "This is the Unit of Measure in which the Vendor sold this item"
    t.decimal  "poreject_qty",               precision: 18, scale: 6, comment: "This is the quantity of the item that was returned"
    t.boolean  "poreject_posted",                                     comment: "This indicates whether or not the return has been recorded in the General Ledger, Inventory History, and Purchase Order Item"
    t.integer  "poreject_rjctcode_id",                                comment: "This indicates the reason for the return"
    t.integer  "poreject_poitem_id",                                  comment: "This is the internal id of the original Purchase Order Item"
    t.boolean  "poreject_invoiced",                                   comment: "This indicates whether the Credit Memo associated with the return has been posted"
    t.integer  "poreject_vohead_id",                                  comment: "This is the Voucher associated with the Purchase Order Item"
    t.text     "poreject_agent_username",                             comment: "This is the Purchase Order Agent responsible for the original Purchase Order"
    t.integer  "poreject_voitem_id",                                  comment: "This is the Voucher Item associated with the Purchase Order Item"
    t.decimal  "poreject_value",             precision: 18, scale: 6, comment: "This is the value (in base currency) of the return at the time it was posted to the General Ledger"
    t.text     "poreject_trans_username",                             comment: "This is the user who recorded the return"
    t.integer  "poreject_recv_id"
  end

  create_table "potype", primary_key: "potype_id", force: :cascade, comment: "Purchase Order Type information" do |t|
    t.text "potype_name"
    t.text "potype_descrip"
  end

  create_table "pr", primary_key: "pr_id", id: :integer, default: -> { "nextval(('\"pr_pr_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Purchase Request information" do |t|
    t.integer  "pr_number"
    t.integer  "pr_subnumber"
    t.string   "pr_status",      limit: 1
    t.string   "pr_order_type",  limit: 1
    t.integer  "pr_order_id"
    t.integer  "pr_poitem_id"
    t.date     "pr_duedate"
    t.integer  "pr_itemsite_id"
    t.decimal  "pr_qtyreq",                precision: 18, scale: 6
    t.integer  "pr_prj_id"
    t.text     "pr_releasenote"
    t.datetime "pr_createdate",                                     default: -> { "now()" }
  end

  create_table "prftcntr", primary_key: "prftcntr_id", force: :cascade, comment: "Profit Center information" do |t|
    t.text "prftcntr_number",  null: false
    t.text "prftcntr_descrip"
    t.index ["prftcntr_number"], name: "prftcntr_prftcntr_number_key", unique: true, using: :btree
  end

  create_table "priv", primary_key: "priv_id", id: :integer, default: -> { "nextval(('priv_priv_id_seq'::text)::regclass)" }, force: :cascade, comment: "System Privilege information" do |t|
    t.text    "priv_module"
    t.text    "priv_name"
    t.text    "priv_descrip"
    t.integer "priv_seq"
    t.index ["priv_name"], name: "priv_name_idx", unique: true, using: :btree
  end

  create_table "prj", primary_key: "prj_id", force: :cascade, comment: "Project information" do |t|
    t.text    "prj_number",                     null: false
    t.text    "prj_name",                       null: false
    t.text    "prj_descrip"
    t.string  "prj_status",           limit: 1, null: false
    t.boolean "prj_so"
    t.boolean "prj_wo"
    t.boolean "prj_po"
    t.text    "prj_owner_username"
    t.date    "prj_start_date"
    t.date    "prj_due_date"
    t.date    "prj_assigned_date"
    t.date    "prj_completed_date"
    t.text    "prj_username"
    t.integer "prj_recurring_prj_id",                        comment: "The first prj record in the series if this is a recurring Project. If the prj_recurring_prj_id is the same as the prj_id, this record is the first in the series."
    t.integer "prj_crmacct_id"
    t.integer "prj_cntct_id"
    t.integer "prj_prjtype_id"
    t.index ["prj_number"], name: "prj_prj_number_key", unique: true, using: :btree
  end

  create_table "prjtask", primary_key: "prjtask_id", force: :cascade, comment: "Project Task information" do |t|
    t.text    "prjtask_number",                                            null: false
    t.text    "prjtask_name",                                              null: false
    t.text    "prjtask_descrip"
    t.integer "prjtask_prj_id",                                            null: false
    t.boolean "prjtask_anyuser"
    t.string  "prjtask_status",         limit: 1,                          null: false
    t.decimal "prjtask_hours_budget",             precision: 18, scale: 6, null: false
    t.decimal "prjtask_hours_actual",             precision: 18, scale: 6, null: false
    t.decimal "prjtask_exp_budget",               precision: 16, scale: 4, null: false
    t.decimal "prjtask_exp_actual",               precision: 16, scale: 4, null: false
    t.text    "prjtask_owner_username"
    t.date    "prjtask_start_date"
    t.date    "prjtask_due_date"
    t.date    "prjtask_assigned_date"
    t.date    "prjtask_completed_date"
    t.text    "prjtask_username"
    t.index ["prjtask_prj_id", "prjtask_number"], name: "prjtask_prjtask_prj_id_key", unique: true, using: :btree
  end

  create_table "prjtaskuser", primary_key: "prjtaskuser_id", force: :cascade, comment: "Project Task user information" do |t|
    t.integer "prjtaskuser_prjtask_id"
    t.text    "prjtaskuser_username"
  end

  create_table "prjtype", primary_key: "prjtype_id", force: :cascade do |t|
    t.text    "prjtype_code"
    t.text    "prjtype_descr"
    t.boolean "prjtype_active", default: true
    t.index ["prjtype_code"], name: "unq_prjtype_code", unique: true, using: :btree
  end

  create_table "prodcat", primary_key: "prodcat_id", id: :integer, default: -> { "nextval(('prodcat_prodcat_id_seq'::text)::regclass)" }, force: :cascade, comment: "Product Category information" do |t|
    t.text "prodcat_code",    null: false
    t.text "prodcat_descrip"
    t.index ["prodcat_code"], name: "prodcat_prodcat_code_key", unique: true, using: :btree
  end

  create_table "prospect", primary_key: "prospect_id", id: :integer, default: -> { "nextval('cust_cust_id_seq'::regclass)" }, force: :cascade, comment: "Prospect Information" do |t|
    t.boolean "prospect_active",      default: true,                         null: false
    t.text    "prospect_number",                                             null: false
    t.text    "prospect_name",                                               null: false
    t.integer "prospect_cntct_id"
    t.text    "prospect_comments"
    t.date    "prospect_created",     default: -> { "('now'::text)::date" }, null: false
    t.integer "prospect_salesrep_id"
    t.integer "prospect_warehous_id"
    t.integer "prospect_taxzone_id"
    t.index ["prospect_number"], name: "prospect_prospect_number_key", unique: true, using: :btree
  end

  create_table "qryhead", primary_key: "qryhead_id", force: :cascade, comment: "A header record for a set of queries to be run sequentially. One use is for data export." do |t|
    t.text "qryhead_name",                                             null: false, comment: "The user-assigned short name for this set of queries."
    t.text "qryhead_descrip",                                                       comment: "A long description of the purpose of this set of queries."
    t.text "qryhead_notes",                                                         comment: "General information about this queryset."
    t.text "qryhead_username", default: -> { "geteffectivextuser()" }, null: false, comment: "The name of the user who last modified this qryhead record."
    t.date "qryhead_updated",  default: -> { "('now'::text)::date" },  null: false, comment: "The date this qryhead was last modified."
    t.index ["qryhead_name"], name: "qryhead_qryhead_name_key", unique: true, using: :btree
  end

  create_table "qryitem", id: false, force: :cascade, comment: "The description of a query to be run as part of a set (see qryhead)." do |t|
    t.serial  "qryitem_id",                                                 null: false, comment: "The primary key, holding an internal value used to cross-reference this table."
    t.integer "qryitem_qryhead_id",                                         null: false, comment: "The primary key of the query set to which this individual query belongs."
    t.text    "qryitem_name",                                               null: false
    t.integer "qryitem_order",                                              null: false, comment: "The order in which query items within a query set should be run."
    t.text    "qryitem_src",                                                null: false, comment: "The source of the query. If the qryitem_src is \"REL\" then the qryitem_group and _detail name a particular table or view and all rows will be returned. If the source is \"MQL\" then the qryitem_group and _detail name a pre-defined MetaSQL query in the metasql table. If the source is \"CUSTOM\" then the qryitem_detail contains the full MetaSQL text of the query to run."
    t.text    "qryitem_group",                                                           comment: "Information to help find the query to run. If the qryitem_src is \"REL\" then this is the schema in which to find the table or view to query and all rows will be returned (the qryitem_detail names the table or view). If the qryitem_src is \"MQL\" then this is the group of the query in the metasql table to run (the name is in qryitem_detail). If the qryitem_src IS \"CUSTOM\" then this ignored."
    t.text    "qryitem_detail",                                             null: false, comment: "The particular query to run. If the qryitem_src is \"REL\" then this is the name of the table or view to query and all rows will be returned. If the qryitem_src is \"MQL\" then this is the name of the query in the metasql table to run. If the qryitem_src IS \"CUSTOM\" then this is the actual MetaSQL query text to be parsed and run."
    t.text    "qryitem_notes",      default: "",                            null: false, comment: "General information about this query."
    t.text    "qryitem_username",   default: -> { "geteffectivextuser()" }, null: false, comment: "The name of the user who last modified this qryitem record."
    t.date    "qryitem_updated",    default: -> { "('now'::text)::date" },  null: false, comment: "The date this qryitem was last modified."
    t.index ["qryitem_qryhead_id", "qryitem_name"], name: "qryitem_qryitem_qryhead_id_key", unique: true, using: :btree
    t.index ["qryitem_qryhead_id", "qryitem_order"], name: "qryitem_qryitem_qryhead_id_key1", unique: true, using: :btree
  end

  create_table "quhead", primary_key: "quhead_id", id: :integer, default: -> { "nextval(('\"quhead_quhead_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Quote header information" do |t|
    t.text    "quhead_number",                                                                           null: false
    t.integer "quhead_cust_id",                                                                          null: false
    t.date    "quhead_quotedate"
    t.integer "quhead_shipto_id"
    t.text    "quhead_shiptoname"
    t.text    "quhead_shiptoaddress1"
    t.text    "quhead_shiptoaddress2"
    t.text    "quhead_shiptoaddress3"
    t.text    "quhead_shiptocity"
    t.text    "quhead_shiptostate"
    t.text    "quhead_shiptozipcode"
    t.text    "quhead_shiptophone"
    t.integer "quhead_salesrep_id"
    t.integer "quhead_terms_id"
    t.decimal "quhead_freight",                 precision: 16, scale: 4
    t.text    "quhead_ordercomments"
    t.text    "quhead_shipcomments"
    t.text    "quhead_billtoname"
    t.text    "quhead_billtoaddress1"
    t.text    "quhead_billtoaddress2"
    t.text    "quhead_billtoaddress3"
    t.text    "quhead_billtocity"
    t.text    "quhead_billtostate"
    t.text    "quhead_billtozip"
    t.decimal "quhead_commission",              precision: 16, scale: 4
    t.text    "quhead_custponumber"
    t.text    "quhead_fob"
    t.text    "quhead_shipvia"
    t.integer "quhead_warehous_id"
    t.date    "quhead_packdate"
    t.integer "quhead_prj_id"
    t.decimal "quhead_misc",                    precision: 16, scale: 4, default: "0.0",                 null: false
    t.integer "quhead_misc_accnt_id"
    t.text    "quhead_misc_descrip"
    t.text    "quhead_billtocountry"
    t.text    "quhead_shiptocountry"
    t.integer "quhead_curr_id",                                          default: -> { "basecurrid()" }
    t.boolean "quhead_imported",                                         default: false
    t.date    "quhead_expire"
    t.boolean "quhead_calcfreight",                                      default: false,                 null: false
    t.integer "quhead_shipto_cntct_id"
    t.text    "quhead_shipto_cntct_honorific"
    t.text    "quhead_shipto_cntct_first_name"
    t.text    "quhead_shipto_cntct_middle"
    t.text    "quhead_shipto_cntct_last_name"
    t.text    "quhead_shipto_cntct_suffix"
    t.text    "quhead_shipto_cntct_phone"
    t.text    "quhead_shipto_cntct_title"
    t.text    "quhead_shipto_cntct_fax"
    t.text    "quhead_shipto_cntct_email"
    t.integer "quhead_billto_cntct_id"
    t.text    "quhead_billto_cntct_honorific"
    t.text    "quhead_billto_cntct_first_name"
    t.text    "quhead_billto_cntct_middle"
    t.text    "quhead_billto_cntct_last_name"
    t.text    "quhead_billto_cntct_suffix"
    t.text    "quhead_billto_cntct_phone"
    t.text    "quhead_billto_cntct_title"
    t.text    "quhead_billto_cntct_fax"
    t.text    "quhead_billto_cntct_email"
    t.integer "quhead_taxzone_id"
    t.integer "quhead_taxtype_id"
    t.integer "quhead_ophead_id"
    t.text    "quhead_status"
    t.integer "quhead_saletype_id",                                                                                   comment: "Associated sale type for quote."
    t.integer "quhead_shipzone_id",                                                                                   comment: "Associated shipping zone for quote."
    t.index ["quhead_number"], name: "quhead_quhead_number_key", unique: true, using: :btree
  end

  create_table "quitem", primary_key: "quitem_id", id: :integer, default: -> { "nextval(('\"quitem_quitem_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Quote Line Item information" do |t|
    t.integer "quitem_quhead_id"
    t.integer "quitem_linenumber"
    t.integer "quitem_itemsite_id"
    t.date    "quitem_scheddate"
    t.decimal "quitem_qtyord",                      precision: 18, scale: 6
    t.decimal "quitem_unitcost",                    precision: 16, scale: 6
    t.decimal "quitem_price",                       precision: 16, scale: 4
    t.decimal "quitem_custprice",                   precision: 16, scale: 4
    t.text    "quitem_memo"
    t.text    "quitem_custpn"
    t.boolean "quitem_createorder"
    t.integer "quitem_order_warehous_id"
    t.integer "quitem_item_id"
    t.decimal "quitem_prcost",                      precision: 16, scale: 6
    t.boolean "quitem_imported",                                              default: false
    t.integer "quitem_qty_uom_id",                                                            null: false
    t.decimal "quitem_qty_invuomratio",             precision: 20, scale: 10,                 null: false
    t.integer "quitem_price_uom_id",                                                          null: false
    t.decimal "quitem_price_invuomratio",           precision: 20, scale: 10,                 null: false
    t.date    "quitem_promdate"
    t.integer "quitem_taxtype_id"
    t.boolean "quitem_dropship",                                              default: false
    t.integer "quitem_itemsrc_id"
    t.string  "quitem_pricemode",         limit: 1,                           default: "D",   null: false, comment: "Pricing mode for quote item.  Valid values are D-discount, and M-markup"
    t.index ["quitem_quhead_id"], name: "quitem_quhead_id_key", using: :btree
  end

  create_table "rahead", primary_key: "rahead_id", force: :cascade, comment: "Return Authorization header information" do |t|
    t.text     "rahead_number",                                                                                        null: false
    t.date     "rahead_authdate",                                              default: -> { "('now'::text)::date" }
    t.date     "rahead_expiredate"
    t.integer  "rahead_salesrep_id"
    t.decimal  "rahead_commission",                   precision: 8,  scale: 4
    t.integer  "rahead_rsncode_id"
    t.string   "rahead_disposition",        limit: 1,                          default: "R"
    t.string   "rahead_timing",             limit: 1
    t.string   "rahead_creditmethod",       limit: 1,                          default: "N"
    t.integer  "rahead_incdt_id"
    t.integer  "rahead_prj_id"
    t.integer  "rahead_cust_id"
    t.text     "rahead_billtoname"
    t.text     "rahead_billtoaddress1"
    t.text     "rahead_billtoaddress2"
    t.text     "rahead_billtoaddress3"
    t.text     "rahead_billtocity"
    t.text     "rahead_billtostate"
    t.text     "rahead_billtozip"
    t.text     "rahead_billtocountry"
    t.integer  "rahead_shipto_id"
    t.text     "rahead_shipto_name"
    t.text     "rahead_shipto_address1"
    t.text     "rahead_shipto_address2"
    t.text     "rahead_shipto_address3"
    t.text     "rahead_shipto_city"
    t.text     "rahead_shipto_state"
    t.text     "rahead_shipto_zipcode"
    t.text     "rahead_shipto_country"
    t.text     "rahead_custponumber"
    t.text     "rahead_notes"
    t.integer  "rahead_misc_accnt_id"
    t.text     "rahead_misc_descrip"
    t.decimal  "rahead_misc",                         precision: 16, scale: 4
    t.integer  "rahead_curr_id",                                               default: -> { "basecurrid()" }
    t.decimal  "rahead_freight",                      precision: 16, scale: 4
    t.boolean  "rahead_printed"
    t.datetime "rahead_lastupdated",                                           default: -> { "now()" }
    t.datetime "rahead_created",                                               default: -> { "now()" }
    t.text     "rahead_creator",                                               default: -> { "geteffectivextuser()" }
    t.integer  "rahead_orig_cohead_id"
    t.integer  "rahead_new_cohead_id"
    t.boolean  "rahead_headcredited",                                          default: false
    t.integer  "rahead_warehous_id"
    t.integer  "rahead_cohead_warehous_id"
    t.integer  "rahead_taxzone_id"
    t.integer  "rahead_taxtype_id"
    t.boolean  "rahead_calcfreight",                                           default: false,                         null: false
    t.integer  "rahead_saletype_id",                                                                                                comment: "Associated sale type for return authorization."
    t.integer  "rahead_shipzone_id",                                                                                                comment: "Associated shipping zone for return authorization."
    t.index ["rahead_number"], name: "rahead_rahead_number_key", unique: true, using: :btree
  end

  create_table "rahist", primary_key: "rahist_id", force: :cascade, comment: "Return Authorization historical transaction information" do |t|
    t.integer "rahist_itemsite_id"
    t.date    "rahist_date",                                 default: -> { "('now'::text)::date" }
    t.text    "rahist_descrip"
    t.decimal "rahist_qty",         precision: 18, scale: 6
    t.integer "rahist_uom_id"
    t.integer "rahist_curr_id",                              default: -> { "basecurrid()" }
    t.text    "rahist_source",                                                                      null: false
    t.integer "rahist_source_id",                                                                   null: false
    t.decimal "rahist_amount",      precision: 16, scale: 4
    t.integer "rahist_rahead_id",                                                                   null: false
  end

  create_table "raitem", primary_key: "raitem_id", force: :cascade, comment: "Return Authorization Line Item information" do |t|
    t.integer "raitem_rahead_id",                                                              null: false
    t.integer "raitem_linenumber",                                                             null: false
    t.integer "raitem_itemsite_id",                                                            null: false
    t.integer "raitem_rsncode_id"
    t.string  "raitem_disposition",        limit: 1,                                           null: false
    t.decimal "raitem_qtyauthorized",                precision: 18, scale: 6,                  null: false
    t.boolean "raitem_warranty",                                               default: false
    t.integer "raitem_qty_uom_id",                                                             null: false
    t.decimal "raitem_qty_invuomratio",              precision: 20, scale: 10,                 null: false
    t.decimal "raitem_qtyreceived",                  precision: 18, scale: 6,  default: "0.0"
    t.decimal "raitem_unitprice",                    precision: 16, scale: 4,                  null: false
    t.integer "raitem_price_uom_id",                                                           null: false
    t.decimal "raitem_price_invuomratio",            precision: 20, scale: 10,                 null: false
    t.decimal "raitem_amtcredited",                  precision: 16, scale: 4,  default: "0.0"
    t.text    "raitem_notes"
    t.string  "raitem_status",             limit: 1,                           default: "O"
    t.integer "raitem_cos_accnt_id"
    t.integer "raitem_orig_coitem_id"
    t.integer "raitem_new_coitem_id"
    t.date    "raitem_scheddate"
    t.decimal "raitem_qtycredited",                  precision: 16, scale: 4,  default: "0.0"
    t.integer "raitem_taxtype_id"
    t.integer "raitem_coitem_itemsite_id"
    t.integer "raitem_subnumber",                                              default: 0,     null: false
    t.decimal "raitem_saleprice",                    precision: 16, scale: 4,  default: "0.0"
    t.decimal "raitem_unitcost",                     precision: 18, scale: 6
    t.text    "raitem_custpn"
    t.index ["raitem_rahead_id", "raitem_linenumber", "raitem_subnumber"], name: "raitem_raitem_rahead_id_key", unique: true, using: :btree
    t.index ["raitem_status"], name: "raitem_raitem_status_idx", using: :btree
  end

  create_table "raitemls", primary_key: "raitemls_id", force: :cascade, comment: "Return Authorization Item Lot/Serial Detail" do |t|
    t.integer "raitemls_raitem_id",                              null: false
    t.integer "raitemls_ls_id",                                  null: false
    t.decimal "raitemls_qtyauthorized", precision: 18, scale: 6, null: false
    t.decimal "raitemls_qtyreceived",   precision: 18, scale: 6, null: false
    t.index ["raitemls_raitem_id", "raitemls_ls_id"], name: "raitemls_raitemls_raitem_id_key", unique: true, using: :btree
  end

  create_table "rcalitem", primary_key: "rcalitem_id", id: :integer, default: -> { "nextval(('\"xcalitem_xcalitem_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Relative Calendar Item information" do |t|
    t.integer "rcalitem_calhead_id"
    t.string  "rcalitem_offsettype",  limit: 1
    t.integer "rcalitem_offsetcount"
    t.string  "rcalitem_periodtype",  limit: 1
    t.integer "rcalitem_periodcount"
    t.text    "rcalitem_name"
  end

  create_table "recur", primary_key: "recur_id", force: :cascade, comment: "Track recurring events and objects." do |t|
    t.integer  "recur_parent_id",                            null: false, comment: "The internal ID of the event/object that recurs."
    t.text     "recur_parent_type",                          null: false, comment: "The table in which the parent event or object is stored."
    t.text     "recur_period",                               null: false, comment: "With recur_freq, how often this event recurs. Values are \"m\" for every minute, \"H\" for every hour, \"D\" for daily, \"W\" for weekly, \"M\" for monthly, \"Y\" for yearly, and \"C\" for customized or complex."
    t.integer  "recur_freq",        default: 1,              null: false, comment: "With recur_period, how often this event recurs. Values are integers counts of recur_periods. For example, if recur_freq = 2 and recur_period = w then the event recurs every 2 weeks."
    t.datetime "recur_start",       default: -> { "now()" },              comment: "The first date/time when the event should occur."
    t.datetime "recur_end",                                               comment: "The last date/time when the event should occur. NULL means there is no end date/time and the event should recur forever."
    t.integer  "recur_max",                                               comment: "The maximum number of recurrence events to create at one time. If this is NULL then when new events are created, a system-wide default will limit the number."
    t.text     "recur_data",                                              comment: "Not yet used and format still undetermined. Additional data to describe how to apply the period and frequency, particularly when period = \"C\"."
    t.index ["recur_parent_id", "recur_parent_type"], name: "recur_recur_parent_id_key", unique: true, using: :btree
  end

  create_table "recurtype", primary_key: "recurtype_id", force: :cascade, comment: "Describes the properties of recurring items/events in way that can be used by stored procedures to maintain the recurrence." do |t|
    t.text "recurtype_type",      null: false, comment: "A code value used by the RecurrenceWidget and the code that uses it to describe the item/event that will recur. Examples include \"INCDT\" for CRM Incidents and \"J\" for Projects."
    t.text "recurtype_table",     null: false, comment: "The table that holds the item/event that will recur."
    t.text "recurtype_donecheck", null: false, comment: "A boolean expression that returns TRUE if an individual item/event record in the recurtype_table has already been completed."
    t.text "recurtype_schedcol",  null: false, comment: "The name of the column in the recurtype_table holding the date or timestamp by which the item is scheduled to be completed or at which the event is supposed to occur."
    t.text "recurtype_limit",                  comment: "A boolean expression that returns TRUE if the current user should see the row in the recurtype_table. NULL indicates there is no specific limitation. For example, the maintainance of recurring TODO items should restricted to those items belonging to the user unless s/he has been granted the privilege to modify other people's todo lists."
    t.text "recurtype_copyfunc",  null: false, comment: "The name of the function to copy an existing item/event record. The copy function is expected to take at least 2 arguments: the id of the item to copy and the new date/timestamp. If the function accepts more than 2, it must be able to accept NULL values for the 3rd and following arguments."
    t.text "recurtype_copyargs",  null: false, comment: "An abbreviated argument list for the copy function. This is used to determine whether the second argument must be cast to a date or a timestamp, and to figure out how many additional arguments to pass.",                                                                                                                                                   array: true
    t.text "recurtype_delfunc",                comment: "The name of the function to delete an existing item/event record. The function is expected to take exactly one argument: the id of the item to delete. NULL indicates there is no delete function and that an SQL DELETE statement can be used. In this case, the id column name will be built as the recurtype_table concatenated with the \"_id\" suffix."
    t.index ["recurtype_type"], name: "recurtype_recurtype_type_key", unique: true, using: :btree
  end

  create_table "recv", primary_key: "recv_id", force: :cascade, comment: "Information about Received Orders." do |t|
    t.text     "recv_order_type",                                                                         null: false
    t.text     "recv_order_number",                                                                       null: false
    t.integer  "recv_orderitem_id",                                                                       null: false
    t.text     "recv_agent_username"
    t.integer  "recv_itemsite_id"
    t.integer  "recv_vend_id"
    t.text     "recv_vend_item_number"
    t.text     "recv_vend_item_descrip"
    t.text     "recv_vend_uom"
    t.decimal  "recv_purchcost",         precision: 16, scale: 6
    t.integer  "recv_purchcost_curr_id"
    t.date     "recv_duedate"
    t.decimal  "recv_qty",               precision: 18, scale: 6
    t.decimal  "recv_recvcost",          precision: 16, scale: 6
    t.integer  "recv_recvcost_curr_id"
    t.decimal  "recv_freight",           precision: 16, scale: 4
    t.integer  "recv_freight_curr_id"
    t.datetime "recv_date"
    t.decimal  "recv_value",             precision: 18, scale: 6
    t.boolean  "recv_posted",                                     default: false,                         null: false
    t.boolean  "recv_invoiced",                                   default: false,                         null: false
    t.integer  "recv_vohead_id"
    t.integer  "recv_voitem_id"
    t.text     "recv_trans_usr_name",                             default: -> { "geteffectivextuser()" }, null: false
    t.text     "recv_notes"
    t.date     "recv_gldistdate"
    t.integer  "recv_splitfrom_id"
    t.date     "recv_rlsd_duedate"
    t.index ["recv_order_type", "recv_orderitem_id"], name: "recv_ordertypeid_idx", using: :btree
  end

  create_table "regtype", primary_key: "regtype_id", force: :cascade, comment: "Warranty Registration Types" do |t|
    t.text "regtype_code",    null: false
    t.text "regtype_descrip"
    t.index ["regtype_code"], name: "regtype_regtype_code_key", unique: true, using: :btree
  end

  create_table "report", primary_key: "report_id", id: :integer, default: -> { "nextval(('report_report_id_seq'::text)::regclass)" }, force: :cascade, comment: "Report definition information" do |t|
    t.text     "report_name"
    t.boolean  "report_sys"
    t.text     "report_source"
    t.text     "report_descrip"
    t.integer  "report_grade",    null: false
    t.datetime "report_loaddate"
    t.index ["report_name", "report_grade"], name: "report_name_grade_idx", unique: true, using: :btree
  end

  create_table "reserve", primary_key: "reserve_id", force: :cascade, comment: "This table is demand reservations on supplies." do |t|
    t.text    "reserve_demand_type",                                    null: false
    t.integer "reserve_demand_id",                                      null: false
    t.text    "reserve_supply_type",                                    null: false
    t.integer "reserve_supply_id",                                      null: false
    t.decimal "reserve_qty",                   precision: 18, scale: 6, null: false
    t.string  "reserve_status",      limit: 1,                          null: false
  end

  create_table "rev", primary_key: "rev_id", force: :cascade, comment: "Used to track document revision information" do |t|
    t.text    "rev_number",                                                       null: false
    t.string  "rev_status",      limit: 1, default: "P",                          null: false
    t.text    "rev_target_type",                                                  null: false
    t.integer "rev_target_id",                                                    null: false
    t.date    "rev_created",               default: -> { "('now'::text)::date" }, null: false
    t.date    "rev_date",                                                         null: false
    t.date    "rev_effective"
    t.date    "rev_expires"
    t.index ["rev_number", "rev_target_type", "rev_target_id"], name: "rev_rev_number_key", unique: true, using: :btree
    t.index ["rev_target_type", "rev_target_id"], name: "rev_target", using: :btree
  end

  create_table "rjctcode", primary_key: "rjctcode_id", id: :integer, default: -> { "nextval(('\"rjctcode_rjctcode_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Reject Code information" do |t|
    t.text "rjctcode_code",    null: false
    t.text "rjctcode_descrip"
    t.index ["rjctcode_code"], name: "rjctcode_rjctcode_code_key", unique: true, using: :btree
  end

  create_table "rsncode", primary_key: "rsncode_id", force: :cascade, comment: "Debit/Credit Memo Reason Code information" do |t|
    t.text "rsncode_code",    null: false
    t.text "rsncode_descrip"
    t.text "rsncode_doctype"
    t.index ["rsncode_code"], name: "rsncode_rsncode_code_key", unique: true, using: :btree
  end

  create_table "sale", primary_key: "sale_id", id: :integer, default: -> { "nextval(('\"sale_sale_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Sale information" do |t|
    t.text    "sale_name",       null: false
    t.text    "sale_descrip"
    t.integer "sale_ipshead_id"
    t.date    "sale_startdate"
    t.date    "sale_enddate"
    t.index ["sale_name"], name: "sale_sale_name_key", unique: true, using: :btree
  end

  create_table "salesaccnt", primary_key: "salesaccnt_id", id: :integer, default: -> { "nextval(('\"salesaccnt_salesaccnt_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Sales Account assignment information" do |t|
    t.integer "salesaccnt_custtype_id"
    t.integer "salesaccnt_prodcat_id"
    t.integer "salesaccnt_warehous_id"
    t.integer "salesaccnt_sales_accnt_id"
    t.integer "salesaccnt_credit_accnt_id"
    t.integer "salesaccnt_cos_accnt_id"
    t.text    "salesaccnt_custtype"
    t.text    "salesaccnt_prodcat"
    t.integer "salesaccnt_returns_accnt_id"
    t.integer "salesaccnt_cor_accnt_id"
    t.integer "salesaccnt_cow_accnt_id"
    t.integer "salesaccnt_saletype_id",      comment: "Associated sale type for sales account."
    t.integer "salesaccnt_shipzone_id",      comment: "Associated shipping zone for sales account."
    t.index ["salesaccnt_prodcat_id"], name: "salesaccnt_prodcat_id_idx", using: :btree
    t.index ["salesaccnt_warehous_id"], name: "salesaccnt_warehous_id_idx", using: :btree
  end

  create_table "salescat", primary_key: "salescat_id", force: :cascade, comment: "Sales Category information" do |t|
    t.boolean "salescat_active"
    t.text    "salescat_name",             null: false
    t.text    "salescat_descrip"
    t.integer "salescat_sales_accnt_id"
    t.integer "salescat_prepaid_accnt_id"
    t.integer "salescat_ar_accnt_id"
    t.index ["salescat_name"], name: "salescat_salescat_name_key", unique: true, using: :btree
  end

  create_table "salesrep", primary_key: "salesrep_id", id: :integer, default: -> { "nextval(('salesrep_salesrep_id_seq'::text)::regclass)" }, force: :cascade, comment: "Sales Representative information" do |t|
    t.boolean "salesrep_active"
    t.text    "salesrep_number",                                       null: false
    t.text    "salesrep_name"
    t.decimal "salesrep_commission",           precision: 8, scale: 4
    t.string  "salesrep_method",     limit: 1
    t.integer "salesrep_emp_id",                                                    comment: "DEPRECATED - the relationship between Sales Rep and Employee is now maintained through the crmacct table."
    t.index ["salesrep_number"], name: "salesrep_salesrep_number_key", unique: true, using: :btree
  end

  create_table "saletype", primary_key: "saletype_id", force: :cascade, comment: "Type or Origination of Sale." do |t|
    t.text    "saletype_code",                    null: false, comment: "User defined identifier for sale type."
    t.text    "saletype_descr",                                comment: "Description for sale type."
    t.boolean "saletype_active",  default: true,  null: false, comment: "Boolean to deactivate a sale type."
    t.boolean "saletype_default", default: false, null: false
  end

  create_table "schemaord", primary_key: "schemaord_id", force: :cascade, comment: "Set the order in which db schemas will appear in the search path after login" do |t|
    t.text    "schemaord_name",  null: false
    t.integer "schemaord_order", null: false
    t.index ["schemaord_name"], name: "schemaord_schemaord_name_key", unique: true, using: :btree
    t.index ["schemaord_order"], name: "schemaord_schemaord_order_key", unique: true, using: :btree
  end

  create_table "script", primary_key: "script_id", force: :cascade do |t|
    t.text    "script_name",                    null: false
    t.integer "script_order",                   null: false
    t.boolean "script_enabled", default: false, null: false
    t.text    "script_source",                  null: false
    t.text    "script_notes"
  end

  create_table "sequence", id: false, force: :cascade, comment: "Pre-populated list of sequence numbers (1-1000) used for printing Labels and other uses" do |t|
    t.integer "sequence_value"
  end

  create_table "shift", primary_key: "shift_id", force: :cascade, comment: "List of work Shifts" do |t|
    t.text "shift_number", null: false
    t.text "shift_name",   null: false
  end

  create_table "shipchrg", primary_key: "shipchrg_id", force: :cascade, comment: "Shipping Charge information" do |t|
    t.text    "shipchrg_name",                  null: false
    t.text    "shipchrg_descrip"
    t.boolean "shipchrg_custfreight"
    t.string  "shipchrg_handling",    limit: 1
  end

  create_table "shipdata", primary_key: ["shipdata_cohead_number", "shipdata_cosmisc_tracknum", "shipdata_cosmisc_packnum_tracknum", "shipdata_void_ind"], force: :cascade, comment: "Shipping Interface information - note that the shipdata_cohead_nember is text and not int.  That is due to ODBC chopping off during the transfer" do |t|
    t.text     "shipdata_cohead_number",                                                                                                             null: false
    t.text     "shipdata_cosmisc_tracknum",                                                                                                          null: false
    t.text     "shipdata_cosmisc_packnum_tracknum",                                                                                                  null: false
    t.decimal  "shipdata_weight",                             precision: 16, scale: 4
    t.decimal  "shipdata_base_freight",                       precision: 16, scale: 4
    t.decimal  "shipdata_total_freight",                      precision: 16, scale: 4
    t.text     "shipdata_shipper",                                                     default: "UPS"
    t.text     "shipdata_billing_option"
    t.text     "shipdata_package_type"
    t.string   "shipdata_void_ind",                 limit: 1,                                                                                        null: false
    t.datetime "shipdata_lastupdated",                                                 default: -> { "('now'::text)::timestamp(6) with time zone" }, null: false
    t.text     "shipdata_shiphead_number"
    t.integer  "shipdata_base_freight_curr_id",                                        default: -> { "basecurrid()" }
    t.integer  "shipdata_total_freight_curr_id",                                       default: -> { "basecurrid()" }
    t.index ["shipdata_cohead_number"], name: "shipdata_cohead_number_idx", using: :btree
  end

  create_table "shipdatasum", primary_key: ["shipdatasum_cohead_number", "shipdatasum_cosmisc_tracknum", "shipdatasum_cosmisc_packnum_tracknum"], force: :cascade, comment: "Shipping Interface information." do |t|
    t.text     "shipdatasum_cohead_number",                                                                                                   null: false
    t.text     "shipdatasum_cosmisc_tracknum",                                                                                                null: false
    t.text     "shipdatasum_cosmisc_packnum_tracknum",                                                                                        null: false
    t.decimal  "shipdatasum_weight",                   precision: 16, scale: 4
    t.decimal  "shipdatasum_base_freight",             precision: 16, scale: 4
    t.decimal  "shipdatasum_total_freight",            precision: 16, scale: 4
    t.text     "shipdatasum_shipper",                                           default: "UPS"
    t.text     "shipdatasum_billing_option"
    t.text     "shipdatasum_package_type"
    t.datetime "shipdatasum_lastupdated",                                       default: -> { "('now'::text)::timestamp(6) with time zone" }, null: false
    t.boolean  "shipdatasum_shipped",                                           default: false
    t.text     "shipdatasum_shiphead_number"
    t.integer  "shipdatasum_base_freight_curr_id",                              default: -> { "basecurrid()" }
    t.integer  "shipdatasum_total_freight_curr_id",                             default: -> { "basecurrid()" }
    t.index ["shipdatasum_cohead_number"], name: "shipdatasum_cohead_number_idx", using: :btree
    t.index ["shipdatasum_cosmisc_tracknum"], name: "shipdatasum_cosmisc_tracknum_idx", using: :btree
  end

  create_table "shipform", primary_key: "shipform_id", id: :integer, default: -> { "nextval(('\"shipform_shipform_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Shipping Form information" do |t|
    t.text    "shipform_name",        null: false
    t.integer "shipform_report_id",                comment: "Obsolete -- reference shipform_report_name instead."
    t.text    "shipform_report_name"
    t.index ["shipform_name"], name: "shipform_shipform_name_key", unique: true, using: :btree
  end

  create_table "shiphead", primary_key: "shiphead_id", force: :cascade, comment: "General information about Shipments" do |t|
    t.integer "shiphead_order_id",                                                                           null: false
    t.text    "shiphead_order_type",                                                                         null: false
    t.text    "shiphead_number",                                                                             null: false
    t.text    "shiphead_shipvia"
    t.decimal "shiphead_freight",                   precision: 16, scale: 4, default: "0.0",                 null: false
    t.integer "shiphead_freight_curr_id",                                    default: -> { "basecurrid()" }, null: false
    t.text    "shiphead_notes"
    t.boolean "shiphead_shipped",                                            default: false,                 null: false
    t.date    "shiphead_shipdate"
    t.integer "shiphead_shipchrg_id"
    t.integer "shiphead_shipform_id"
    t.string  "shiphead_sfstatus",        limit: 1,                                                          null: false
    t.text    "shiphead_tracknum"
    t.index ["shiphead_number"], name: "shiphead_shiphead_number_key", unique: true, using: :btree
    t.index ["shiphead_order_id"], name: "shiphead_order_id_idx", using: :btree
    t.index ["shiphead_shipped"], name: "shiphead_shipped_idx", using: :btree
  end

  create_table "shipitem", primary_key: "shipitem_id", force: :cascade, comment: "Information about Shipment Line Items" do |t|
    t.integer  "shipitem_orderitem_id",                                            null: false
    t.integer  "shipitem_shiphead_id",                                             null: false
    t.decimal  "shipitem_qty",            precision: 18, scale: 6,                 null: false
    t.boolean  "shipitem_shipped",                                 default: false, null: false
    t.datetime "shipitem_shipdate"
    t.datetime "shipitem_transdate"
    t.text     "shipitem_trans_username"
    t.boolean  "shipitem_invoiced",                                default: false, null: false
    t.integer  "shipitem_invcitem_id"
    t.decimal  "shipitem_value",          precision: 18, scale: 6
    t.integer  "shipitem_invhist_id"
    t.index ["shipitem_invcitem_id"], name: "shipitem_invcitem_id_idx", using: :btree
    t.index ["shipitem_orderitem_id"], name: "shipitem_orderitem_id_idx", using: :btree
    t.index ["shipitem_shiphead_id"], name: "shipitem_shiphead_id_idx", using: :btree
  end

  create_table "shipitemlocrsrv", primary_key: "shipitemlocrsrv_id", force: :cascade, comment: "This table records reservations by location used to fullfill issue. Used to restore reservation state if stock returned" do |t|
    t.integer "shipitemlocrsrv_shipitem_id",                          null: false
    t.integer "shipitemlocrsrv_itemsite_id",                          null: false
    t.integer "shipitemlocrsrv_location_id",                          null: false
    t.integer "shipitemlocrsrv_ls_id"
    t.date    "shipitemlocrsrv_expiration"
    t.date    "shipitemlocrsrv_warrpurc"
    t.decimal "shipitemlocrsrv_qty",         precision: 18, scale: 6, null: false
  end

  create_table "shipitemrsrv", primary_key: "shipitemrsrv_id", force: :cascade do |t|
    t.integer "shipitemrsrv_shipitem_id"
    t.decimal "shipitemrsrv_qty",         precision: 18, scale: 6
  end

  create_table "shiptoinfo", primary_key: "shipto_id", id: :integer, default: -> { "nextval(('shipto_shipto_id_seq'::text)::regclass)" }, force: :cascade, comment: "Ship-To information" do |t|
    t.integer "shipto_cust_id",                                                     null: false
    t.text    "shipto_name"
    t.integer "shipto_salesrep_id"
    t.text    "shipto_comments"
    t.text    "shipto_shipcomments"
    t.integer "shipto_shipzone_id"
    t.text    "shipto_shipvia"
    t.decimal "shipto_commission",            precision: 10, scale: 4,              null: false
    t.integer "shipto_shipform_id"
    t.integer "shipto_shipchrg_id"
    t.boolean "shipto_active",                                                      null: false
    t.boolean "shipto_default"
    t.text    "shipto_num"
    t.integer "shipto_ediprofile_id",                                                            comment: "Deprecated column - DO NOT USE"
    t.integer "shipto_cntct_id"
    t.integer "shipto_addr_id"
    t.integer "shipto_taxzone_id"
    t.integer "shipto_preferred_warehous_id",                          default: -1, null: false
    t.index ["shipto_cust_id", "shipto_num"], name: "shipto_num_cust_unique", unique: true, using: :btree
  end

  create_table "shipvia", primary_key: "shipvia_id", id: :integer, default: -> { "nextval(('shipvia_shipvia_id_seq'::text)::regclass)" }, force: :cascade, comment: "Ship Via information" do |t|
    t.text "shipvia_code",    null: false
    t.text "shipvia_descrip"
    t.index ["shipvia_code"], name: "shipvia_shipvia_code_key", unique: true, using: :btree
  end

  create_table "shipzone", primary_key: "shipzone_id", id: :integer, default: -> { "nextval(('shipzone_shipzone_id_seq'::text)::regclass)" }, force: :cascade, comment: "Shipping Zone information" do |t|
    t.text "shipzone_name",    null: false
    t.text "shipzone_descrip"
    t.index ["shipzone_name"], name: "shipzone_shipzone_name_key", unique: true, using: :btree
  end

  create_table "sitetype", primary_key: "sitetype_id", force: :cascade, comment: "This table is the different types of sites." do |t|
    t.text "sitetype_name",    null: false
    t.text "sitetype_descrip"
    t.index ["sitetype_name"], name: "sitetype_sitetype_name_key", unique: true, using: :btree
  end

  create_table "sltrans", primary_key: "sltrans_id", id: :integer, default: -> { "nextval('gltrans_gltrans_id_seq'::regclass)" }, force: :cascade, comment: "Journal transaction information" do |t|
    t.datetime "sltrans_created"
    t.date     "sltrans_date",                                                                                   null: false
    t.integer  "sltrans_sequence"
    t.integer  "sltrans_accnt_id",                                                                               null: false
    t.text     "sltrans_source"
    t.text     "sltrans_docnumber"
    t.integer  "sltrans_misc_id"
    t.decimal  "sltrans_amount",                precision: 20, scale: 2,                                         null: false
    t.text     "sltrans_notes"
    t.integer  "sltrans_journalnumber"
    t.boolean  "sltrans_posted",                                                                                 null: false
    t.text     "sltrans_doctype"
    t.text     "sltrans_username",                                       default: -> { "geteffectivextuser()" }, null: false
    t.integer  "sltrans_gltrans_journalnumber"
    t.boolean  "sltrans_rec",                                            default: false,                         null: false
    t.index ["sltrans_accnt_id"], name: "sltrans_sltrans_accnt_id_idx", using: :btree
    t.index ["sltrans_date"], name: "sltrans_sltrans_date_idx", using: :btree
    t.index ["sltrans_journalnumber"], name: "sltrans_sltrans_journalnumber_idx", using: :btree
    t.index ["sltrans_sequence"], name: "sltrans_sequence_idx", using: :btree
  end

  create_table "sltrans_backup", id: false, force: :cascade, comment: "backup cross references of old and new ids for sltrans 4.0 upgrade." do |t|
    t.integer "sltrans_old_id"
    t.integer "sltrans_new_id"
  end

  create_table "source", primary_key: "source_id", force: :cascade, comment: "Used to describe different types of document for tax classes, document associations, comment associations, and characteristic associations" do |t|
    t.text     "source_module",                                              comment: "Application module"
    t.text     "source_name",                                   null: false, comment: "Abbreviation for this document type used on comment associations."
    t.text     "source_descrip",                                             comment: "Human-readable English name for this document type. The client application tries to translate this whenever possible."
    t.integer  "source_docass_num",    default: 0,              null: false, comment: "Value from the desktop client's Document::DocumentSources enumeration corresponding to this document type."
    t.text     "source_docass",        default: "",             null: false, comment: "Abbreviation for this document type used on document associations (docass). Empty indicates cannot used for document associations (see source_widget)."
    t.text     "source_charass",       default: "",             null: false, comment: "Abbreviation for this document type used on characteristic associations (charass). Empty indicates not used for characteristics."
    t.text     "source_table",         default: "",             null: false, comment: "The primary table in which this document is stored."
    t.text     "source_key_field",     default: "",             null: false, comment: "The primary key field in the primary table for this document type."
    t.text     "source_number_field",  default: "",             null: false, comment: "The column holding the main human-readable identifier for this document (e.g. Bill of Materials document number)."
    t.text     "source_name_field",    default: "",             null: false, comment: "The column holding the secondary description of this document (e.g. the Item built by a Bill of Materials)."
    t.text     "source_desc_field",    default: "",             null: false, comment: "The column holding the longer description of this document (e.g. the first line of the Item's Description for a Bill of Materials)."
    t.text     "source_widget",        default: "",             null: false, comment: "A hint to the client application of how to let the user select a document to attach. \"core\" means that the C++ application handles this document type natively. A value starting with \"SELECT\" is interpreted as a query to populate a combobox, while values containing \"Cluster\" are treated as the name of a C++ VirtualCluster subclass to instantiate. Empty string means this cannot be used by the desktop client to create document associations (see source_docass)."
    t.text     "source_joins",         default: "",             null: false, comment: "An optional string to add to the FROM clause to get auxiliary information (e.g. \"join item_id on bomhead_item_id=item_id\")."
    t.text     "source_key_param",     default: "",             null: false, comment: "The name of the parameter interpreted by the desktop client's \"set\" method as containing the primary key to retrieve the main document record for editing or viewing (e.g. most desktop windows take the sales order id in a \"sohead_id\" parameter even though the database field is \"cohead_id\")."
    t.text     "source_uiform_name",   default: "",             null: false, comment: "The name of the desktop client application window to open to view or edit this document (e.g. \"salesOrder\")."
    t.text     "source_create_priv",   default: "",             null: false, comment: "A space- or +-delimited set of privileges required to allow creating a new document. If this is specified, an item will be added to the desktop client's \"New\" button menu."
    t.datetime "source_created",       default: -> { "now()" }, null: false, comment: "The date this source record was created (or the date this column was added to the table:-)."
    t.datetime "source_last_modified", default: -> { "now()" }, null: false, comment: "The date this source record was last edited."
    t.index ["source_name"], name: "source_source_name_key", unique: true, using: :btree
  end

  create_table "state", primary_key: "state_id", force: :cascade, comment: "List of states, provinces, and territories associated with various countries." do |t|
    t.text    "state_name",       null: false
    t.text    "state_abbr"
    t.integer "state_country_id"
    t.index ["state_country_id", "state_name"], name: "state_state_country_id_key", unique: true, using: :btree
  end

  create_table "status", primary_key: "status_id", force: :cascade do |t|
    t.text    "status_type",                              null: false
    t.string  "status_code",  limit: 1,                   null: false
    t.text    "status_name"
    t.integer "status_seq"
    t.text    "status_color",           default: "white"
    t.index ["status_type", "status_code"], name: "status_status_type_key", unique: true, using: :btree
  end

  create_table "stdjrnl", primary_key: "stdjrnl_id", force: :cascade, comment: "Standard Journal information" do |t|
    t.text "stdjrnl_name",    null: false
    t.text "stdjrnl_descrip"
    t.text "stdjrnl_notes"
    t.index ["stdjrnl_name"], name: "stdjrnl_stdjrnl_name_key", unique: true, using: :btree
  end

  create_table "stdjrnlgrp", primary_key: "stdjrnlgrp_id", force: :cascade, comment: "Standard Journal Group information" do |t|
    t.text "stdjrnlgrp_name",    null: false
    t.text "stdjrnlgrp_descrip"
    t.index ["stdjrnlgrp_name"], name: "stdjrnlgrp_stdjrnlgrp_name_key", unique: true, using: :btree
  end

  create_table "stdjrnlgrpitem", primary_key: "stdjrnlgrpitem_id", force: :cascade, comment: "Standard Journal Group Item information" do |t|
    t.integer "stdjrnlgrpitem_stdjrnl_id"
    t.integer "stdjrnlgrpitem_toapply"
    t.integer "stdjrnlgrpitem_applied"
    t.date    "stdjrnlgrpitem_effective"
    t.date    "stdjrnlgrpitem_expires"
    t.integer "stdjrnlgrpitem_stdjrnlgrp_id"
  end

  create_table "stdjrnlitem", primary_key: "stdjrnlitem_id", force: :cascade, comment: "Standard Journal Item information" do |t|
    t.integer "stdjrnlitem_stdjrnl_id",                          null: false
    t.integer "stdjrnlitem_accnt_id",                            null: false
    t.decimal "stdjrnlitem_amount",     precision: 20, scale: 2, null: false
    t.text    "stdjrnlitem_notes"
  end

  create_table "subaccnt", primary_key: "subaccnt_id", force: :cascade, comment: "Subaccount information" do |t|
    t.text "subaccnt_number",  null: false
    t.text "subaccnt_descrip"
    t.index ["subaccnt_number"], name: "subaccnt_subaccnt_number_key", unique: true, using: :btree
  end

  create_table "subaccnttype", primary_key: "subaccnttype_id", force: :cascade, comment: "User defined Sub Account Types." do |t|
    t.string "subaccnttype_accnt_type", limit: 1, null: false
    t.text   "subaccnttype_code",                 null: false
    t.text   "subaccnttype_descrip"
    t.index ["subaccnttype_code"], name: "subaccnttype_code_idx", unique: true, using: :btree
  end

  create_table "tax", primary_key: "tax_id", id: :integer, default: -> { "nextval(('\"tax_tax_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Tax information" do |t|
    t.text    "tax_code",           null: false
    t.text    "tax_descrip"
    t.integer "tax_sales_accnt_id",              comment: "Deprecated column - DO NOT USE"
    t.integer "tax_taxclass_id"
    t.integer "tax_taxauth_id"
    t.integer "tax_basis_tax_id"
    t.integer "tax_dist_accnt_id"
  end

  create_table "taxass", primary_key: "taxass_id", force: :cascade, comment: "The tax assignment table associates different tax zones and tax types to a given set of tax codes." do |t|
    t.integer "taxass_taxzone_id",              comment: "The id of the tax zone. If NULL any tax zone will apply."
    t.integer "taxass_taxtype_id",              comment: "The id of the tax type. If NULL any tax type will apply."
    t.integer "taxass_tax_id",     null: false, comment: "The id of the tax code."
    t.index ["taxass_taxzone_id", "taxass_taxtype_id", "taxass_tax_id"], name: "taxass_taxass_taxzone_id_key", unique: true, using: :btree
  end

  create_table "taxauth", primary_key: "taxauth_id", force: :cascade, comment: "The Tax Authority table." do |t|
    t.text    "taxauth_code",     null: false
    t.text    "taxauth_name"
    t.text    "taxauth_extref"
    t.integer "taxauth_addr_id"
    t.integer "taxauth_curr_id",               comment: "The required currency for recording tax information as. NULL means no preference."
    t.text    "taxauth_county"
    t.integer "taxauth_accnt_id"
    t.index ["taxauth_code"], name: "taxauth_taxauth_code_key", unique: true, using: :btree
  end

  create_table "taxclass", primary_key: "taxclass_id", force: :cascade, comment: "Tax class information" do |t|
    t.text    "taxclass_code",     null: false, comment: "Code"
    t.text    "taxclass_descrip",               comment: "Description"
    t.integer "taxclass_sequence",              comment: "Group sequence"
    t.index ["taxclass_code"], name: "taxclass_taxclass_code_key", unique: true, using: :btree
  end

  create_table "taxhist", primary_key: "taxhist_id", force: :cascade, comment: "A table type to record tax transaction history. Inherited by other tables that actually record history. As the parent, queries can be run against it that will join all child tables. " do |t|
    t.integer "taxhist_parent_id",                              null: false, comment: "Source parent id."
    t.integer "taxhist_taxtype_id",                                          comment: "Tax type id"
    t.integer "taxhist_tax_id",                                 null: false, comment: "Tax code id."
    t.decimal "taxhist_basis",         precision: 16, scale: 2, null: false, comment: "Base price amount on which the tax calculation is based."
    t.integer "taxhist_basis_tax_id",                                        comment: "Tax rate calculation basis.  If null, then the amount of the parent document, otherwise calculated on the result amount of the tax code id referenced."
    t.integer "taxhist_sequence"
    t.decimal "taxhist_percent",       precision: 10, scale: 6, null: false
    t.decimal "taxhist_amount",        precision: 16, scale: 2, null: false, comment: "Flat tax amount."
    t.decimal "taxhist_tax",           precision: 16, scale: 6, null: false, comment: "Calculated tax amount."
    t.date    "taxhist_docdate",                                null: false, comment: "The date of the parent document."
    t.date    "taxhist_distdate",                                            comment: "The G/L distribution date of the parent document."
    t.integer "taxhist_curr_id"
    t.decimal "taxhist_curr_rate"
    t.integer "taxhist_journalnumber"
    t.index ["taxhist_parent_id", "taxhist_taxtype_id"], name: "taxhist_taxhist_parent_type_idx", using: :btree
    t.index ["taxhist_parent_id"], name: "taxhist_taxhist_parent_id_idx", using: :btree
    t.index ["taxhist_taxtype_id"], name: "taxhist_taxhist_taxtype_id_idx", using: :btree
  end

  create_table "taxpay", primary_key: "taxpay_id", force: :cascade do |t|
    t.integer "taxpay_taxhist_id", null: false
    t.integer "taxpay_apply_id",   null: false
    t.date    "taxpay_distdate",   null: false
    t.decimal "taxpay_tax",        null: false
  end

  create_table "taxrate", primary_key: "taxrate_id", force: :cascade, comment: "Tax rates." do |t|
    t.integer "taxrate_tax_id",                             null: false, comment: "The id of the parent tax code."
    t.decimal "taxrate_percent",   precision: 10, scale: 6, null: false, comment: "Tax rate percentage."
    t.integer "taxrate_curr_id",                                         comment: "The currency id of the flat rate amount."
    t.decimal "taxrate_amount",    precision: 16, scale: 2, null: false, comment: "Flat tax rate amount."
    t.date    "taxrate_effective",                                       comment: "The effective date of the tax rate.  NULL value means always."
    t.date    "taxrate_expires",                                         comment: "The expire date of the tax rate.  NULL value means never."
  end

  create_table "taxreg", primary_key: "taxreg_id", force: :cascade, comment: "Stores Tax Registration numbers related to objects and a given tax authority. The rel_id specifies the object id and teh rel_type specifies the object type. See column comment for additional detail on types." do |t|
    t.integer "taxreg_rel_id",                                                null: false
    t.string  "taxreg_rel_type",   limit: 1,                                               comment: "The type of relation this record is for. Known values are C=Customer, V=Vendor, NULL=This Manufacturer in which case taxreg_rel_id is meaningless and should be -1."
    t.integer "taxreg_taxauth_id"
    t.text    "taxreg_number",                                                null: false
    t.integer "taxreg_taxzone_id"
    t.date    "taxreg_effective",            default: -> { "startoftime()" }
    t.date    "taxreg_expires",              default: -> { "endoftime()" }
    t.text    "taxreg_notes",                default: ""
  end

  create_table "taxtype", primary_key: "taxtype_id", force: :cascade, comment: "The list of Tax Types" do |t|
    t.text    "taxtype_name",                    null: false
    t.text    "taxtype_descrip"
    t.boolean "taxtype_sys",     default: false, null: false
    t.index ["taxtype_name"], name: "taxtype_taxtype_name_key", unique: true, using: :btree
  end

  create_table "taxzone", primary_key: "taxzone_id", force: :cascade, comment: "Tax zone information" do |t|
    t.text "taxzone_code",    null: false, comment: "Code"
    t.text "taxzone_descrip",              comment: "Description"
    t.index ["taxzone_code"], name: "taxzone_taxzone_code_key", unique: true, using: :btree
  end

  create_table "terms", primary_key: "terms_id", id: :integer, default: -> { "nextval(('terms_terms_id_seq'::text)::regclass)" }, force: :cascade, comment: "Billing Terms information" do |t|
    t.text    "terms_code",                                                        null: false
    t.text    "terms_descrip"
    t.string  "terms_type",      limit: 1
    t.integer "terms_duedays"
    t.integer "terms_discdays"
    t.decimal "terms_discprcnt",           precision: 10, scale: 6
    t.integer "terms_cutoffday"
    t.boolean "terms_ap"
    t.boolean "terms_ar"
    t.boolean "terms_fincharg",                                     default: true, null: false
    t.index ["terms_code"], name: "terms_terms_code_key", unique: true, using: :btree
  end

  create_table "todoitem", primary_key: "todoitem_id", force: :cascade, comment: "To-Do List items." do |t|
    t.text    "todoitem_name",                                                                    null: false
    t.text    "todoitem_description"
    t.integer "todoitem_incdt_id"
    t.text    "todoitem_creator_username",                default: -> { "geteffectivextuser()" }, null: false
    t.string  "todoitem_status",                limit: 1
    t.boolean "todoitem_active",                          default: true,                          null: false
    t.date    "todoitem_start_date"
    t.date    "todoitem_due_date"
    t.date    "todoitem_assigned_date"
    t.date    "todoitem_completed_date"
    t.integer "todoitem_seq",                             default: 0,                             null: false
    t.text    "todoitem_notes"
    t.integer "todoitem_crmacct_id"
    t.integer "todoitem_ophead_id"
    t.text    "todoitem_owner_username"
    t.integer "todoitem_priority_id"
    t.text    "todoitem_username"
    t.integer "todoitem_recurring_todoitem_id",                                                                comment: "The first todoitem record in the series if this is a recurring To-Do item. If the todoitem_recurring_todoitem_id is the same as the todoitem_id, this record is the first in the series."
    t.integer "todoitem_cntct_id"
    t.index ["todoitem_username"], name: "todoitem_todoitem_username_idx", using: :btree
  end

  create_table "tohead", primary_key: "tohead_id", force: :cascade, comment: "Header information about Transfer Orders." do |t|
    t.text     "tohead_number",                                                                                      null: false
    t.string   "tohead_status",           limit: 1
    t.date     "tohead_orderdate"
    t.integer  "tohead_src_warehous_id",                                                                             null: false
    t.text     "tohead_srcname"
    t.text     "tohead_srcaddress1"
    t.text     "tohead_srcaddress2"
    t.text     "tohead_srcaddress3"
    t.text     "tohead_srccity"
    t.text     "tohead_srcstate"
    t.text     "tohead_srcpostalcode"
    t.text     "tohead_srccountry"
    t.integer  "tohead_srccntct_id"
    t.text     "tohead_srccntct_name"
    t.text     "tohead_srcphone"
    t.integer  "tohead_trns_warehous_id",                                                                            null: false
    t.text     "tohead_trnsname"
    t.integer  "tohead_dest_warehous_id",                                                                            null: false
    t.text     "tohead_destname"
    t.text     "tohead_destaddress1"
    t.text     "tohead_destaddress2"
    t.text     "tohead_destaddress3"
    t.text     "tohead_destcity"
    t.text     "tohead_deststate"
    t.text     "tohead_destpostalcode"
    t.text     "tohead_destcountry"
    t.integer  "tohead_destcntct_id"
    t.text     "tohead_destcntct_name"
    t.text     "tohead_destphone"
    t.text     "tohead_agent_username"
    t.text     "tohead_shipvia"
    t.integer  "tohead_shipform_id"
    t.integer  "tohead_shipchrg_id"
    t.decimal  "tohead_freight",                    precision: 16, scale: 4, default: "0.0",                         null: false
    t.integer  "tohead_freight_curr_id",                                     default: -> { "basecurrid()" }
    t.boolean  "tohead_shipcomplete",                                        default: false,                         null: false
    t.text     "tohead_ordercomments"
    t.text     "tohead_shipcomments"
    t.date     "tohead_packdate"
    t.integer  "tohead_prj_id"
    t.datetime "tohead_lastupdated",                                         default: -> { "now()" },                null: false
    t.datetime "tohead_created",                                             default: -> { "now()" },                null: false
    t.text     "tohead_creator",                                             default: -> { "geteffectivextuser()" }, null: false
    t.integer  "tohead_taxzone_id"
    t.index ["tohead_number"], name: "tohead_tohead_number_key", unique: true, using: :btree
    t.index ["tohead_status"], name: "tohead_tohead_status_idx", using: :btree
  end

  create_table "toheadtax", primary_key: "taxhist_id", id: :integer, default: -> { "nextval('taxhist_taxhist_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "taxhist_parent_id",                              null: false
    t.integer "taxhist_taxtype_id"
    t.integer "taxhist_tax_id",                                 null: false
    t.decimal "taxhist_basis",         precision: 16, scale: 2, null: false
    t.integer "taxhist_basis_tax_id"
    t.integer "taxhist_sequence"
    t.decimal "taxhist_percent",       precision: 10, scale: 6, null: false
    t.decimal "taxhist_amount",        precision: 16, scale: 2, null: false
    t.decimal "taxhist_tax",           precision: 16, scale: 6, null: false
    t.date    "taxhist_docdate",                                null: false
    t.date    "taxhist_distdate"
    t.integer "taxhist_curr_id"
    t.decimal "taxhist_curr_rate"
    t.integer "taxhist_journalnumber"
    t.index ["taxhist_parent_id", "taxhist_taxtype_id"], name: "toheadtax_taxhist_parent_type_idx", using: :btree
    t.index ["taxhist_parent_id"], name: "toheadtax_taxhist_parent_id_idx", using: :btree
    t.index ["taxhist_taxtype_id"], name: "toheadtax_taxhist_taxtype_id_idx", using: :btree
  end

  create_table "toitem", primary_key: "toitem_id", force: :cascade, comment: "Transfer Order Line Item information" do |t|
    t.integer  "toitem_tohead_id",                                                                                   null: false
    t.integer  "toitem_linenumber"
    t.integer  "toitem_item_id",                                                                                     null: false
    t.string   "toitem_status",           limit: 1,                                                                  null: false
    t.date     "toitem_duedate",                                                                                     null: false
    t.date     "toitem_schedshipdate",                                                                               null: false
    t.date     "toitem_schedrecvdate"
    t.decimal  "toitem_qty_ordered",                precision: 18, scale: 6,                                         null: false
    t.decimal  "toitem_qty_shipped",                precision: 18, scale: 6, default: "0.0",                         null: false
    t.decimal  "toitem_qty_received",               precision: 18, scale: 6, default: "0.0",                         null: false
    t.text     "toitem_uom",                                                                                         null: false
    t.decimal  "toitem_stdcost",                    precision: 16, scale: 6,                                         null: false
    t.integer  "toitem_prj_id"
    t.decimal  "toitem_freight",                    precision: 16, scale: 4, default: "0.0",                         null: false
    t.integer  "toitem_freight_curr_id"
    t.text     "toitem_notes"
    t.datetime "toitem_closedate"
    t.text     "toitem_close_username"
    t.datetime "toitem_lastupdated",                                         default: -> { "now()" },                null: false
    t.datetime "toitem_created",                                             default: -> { "now()" },                null: false
    t.text     "toitem_creator",                                             default: -> { "geteffectivextuser()" }, null: false
    t.decimal  "toitem_freight_received",           precision: 16, scale: 4, default: "0.0",                         null: false
    t.index ["toitem_item_id"], name: "toitem_item_id_idx", using: :btree
    t.index ["toitem_linenumber"], name: "toitem_linenumber_idx", using: :btree
    t.index ["toitem_status"], name: "toitem_status_idx", using: :btree
    t.index ["toitem_tohead_id"], name: "toitem_tohead_id_idx", using: :btree
  end

  create_table "toitemtax", primary_key: "taxhist_id", id: :integer, default: -> { "nextval('taxhist_taxhist_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "taxhist_parent_id",                              null: false
    t.integer "taxhist_taxtype_id"
    t.integer "taxhist_tax_id",                                 null: false
    t.decimal "taxhist_basis",         precision: 16, scale: 2, null: false
    t.integer "taxhist_basis_tax_id"
    t.integer "taxhist_sequence"
    t.decimal "taxhist_percent",       precision: 10, scale: 6, null: false
    t.decimal "taxhist_amount",        precision: 16, scale: 2, null: false
    t.decimal "taxhist_tax",           precision: 16, scale: 6, null: false
    t.date    "taxhist_docdate",                                null: false
    t.date    "taxhist_distdate"
    t.integer "taxhist_curr_id"
    t.decimal "taxhist_curr_rate"
    t.integer "taxhist_journalnumber"
    t.index ["taxhist_parent_id", "taxhist_taxtype_id"], name: "toitemtax_taxhist_parent_type_idx", using: :btree
    t.index ["taxhist_parent_id"], name: "toitemtax_taxhist_parent_id_idx", using: :btree
    t.index ["taxhist_taxtype_id"], name: "toitemtax_taxhist_taxtype_id_idx", using: :btree
  end

  create_table "trgthist", id: false, force: :cascade do |t|
    t.integer "trgthist_src_cntct_id",  null: false
    t.integer "trgthist_trgt_cntct_id", null: false
    t.text    "trgthist_col",           null: false
    t.text    "trgthist_value",         null: false
  end

  create_table "trialbal", primary_key: "trialbal_id", force: :cascade, comment: "Trial Balance information" do |t|
    t.integer "trialbal_period_id"
    t.integer "trialbal_accnt_id"
    t.decimal "trialbal_beginning", precision: 20, scale: 2
    t.decimal "trialbal_ending",    precision: 20, scale: 2
    t.decimal "trialbal_credits",   precision: 20, scale: 2
    t.decimal "trialbal_debits",    precision: 20, scale: 2
    t.boolean "trialbal_dirty"
    t.decimal "trialbal_yearend",   precision: 20, scale: 2, default: "0.0", null: false
    t.index ["trialbal_accnt_id", "trialbal_period_id"], name: "trialbal_accnt_period_idx", unique: true, using: :btree
  end

  create_table "trialbalsync", primary_key: "trialbal_id", id: :integer, default: -> { "nextval('trialbal_trialbal_id_seq'::regclass)" }, force: :cascade, comment: "Trial balance synchronization table." do |t|
    t.integer "trialbal_period_id"
    t.integer "trialbal_accnt_id"
    t.decimal "trialbal_beginning",          precision: 20, scale: 2
    t.decimal "trialbal_ending",             precision: 20, scale: 2
    t.decimal "trialbal_credits",            precision: 20, scale: 2
    t.decimal "trialbal_debits",             precision: 20, scale: 2
    t.boolean "trialbal_dirty"
    t.decimal "trialbal_yearend",            precision: 20, scale: 2, default: "0.0", null: false
    t.decimal "trialbalsync_curr_beginning", precision: 20, scale: 2, default: "0.0", null: false, comment: "Beginning balance in source transaction currency"
    t.decimal "trialbalsync_curr_ending",    precision: 20, scale: 2, default: "0.0", null: false, comment: "Ending balance in source transaction currency"
    t.decimal "trialbalsync_curr_credits",   precision: 20, scale: 2, default: "0.0", null: false, comment: "Credits in source transaction currency"
    t.decimal "trialbalsync_curr_debits",    precision: 20, scale: 2, default: "0.0", null: false, comment: "Year end in source transaction currency"
    t.decimal "trialbalsync_curr_yearend",   precision: 20, scale: 2, default: "0.0", null: false
    t.boolean "trialbalsync_curr_posted",                             default: false, null: false
    t.integer "trialbalsync_curr_id",                                                 null: false, comment: "Currency table reference"
    t.decimal "trialbalsync_curr_rate",                                                            comment: "Currency conversion rate applied"
    t.index ["trialbal_period_id", "trialbal_accnt_id"], name: "trialbalsync_trialbal_period_id_key", unique: true, using: :btree
  end

  create_table "uiform", primary_key: "uiform_id", force: :cascade do |t|
    t.text    "uiform_name",                    null: false
    t.integer "uiform_order",                   null: false
    t.boolean "uiform_enabled", default: false, null: false
    t.text    "uiform_source",                  null: false
    t.text    "uiform_notes"
  end

  create_table "uom", primary_key: "uom_id", force: :cascade, comment: "Unit of Measure information" do |t|
    t.text    "uom_name",                        null: false
    t.text    "uom_descrip"
    t.boolean "uom_item_weight", default: false, null: false
    t.index ["uom_name"], name: "uom_uom_name_key", unique: true, using: :btree
  end

  create_table "uomconv", primary_key: "uomconv_id", force: :cascade, comment: "UOM conversion information. From Unit to To Unit with a value per ratio." do |t|
    t.integer "uomconv_from_uom_id",                                           null: false
    t.decimal "uomconv_from_value",  precision: 20, scale: 10,                 null: false
    t.integer "uomconv_to_uom_id",                                             null: false
    t.decimal "uomconv_to_value",    precision: 20, scale: 10,                 null: false
    t.boolean "uomconv_fractional",                            default: false, null: false
  end

  create_table "uomtype", primary_key: "uomtype_id", force: :cascade, comment: "UOM Type values." do |t|
    t.text    "uomtype_name",                     null: false
    t.text    "uomtype_descrip"
    t.boolean "uomtype_multiple", default: false, null: false
    t.index ["uomtype_name"], name: "uomtype_uomtype_name_key", unique: true, using: :btree
  end

  create_table "urlinfo", primary_key: "url_id", force: :cascade do |t|
    t.text "url_title", null: false
    t.text "url_url",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "token",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["token"], name: "index_users_on_token", unique: true, using: :btree
  end

  create_table "usr_bak", primary_key: "usr_id", id: :integer, default: -> { "nextval(('usr_usr_id_seq'::text)::regclass)" }, force: :cascade, comment: "User information" do |t|
    t.text    "usr_username",   null: false
    t.text    "usr_propername"
    t.text    "usr_passwd"
    t.integer "usr_locale_id",  null: false
    t.text    "usr_initials"
    t.boolean "usr_agent",      null: false
    t.boolean "usr_active",     null: false
    t.text    "usr_email"
    t.text    "usr_window"
    t.index ["usr_username"], name: "usr_usr_username_key", unique: true, using: :btree
  end

  create_table "usrgrp", primary_key: "usrgrp_id", force: :cascade, comment: "This is which group a user belongs to." do |t|
    t.integer "usrgrp_grp_id",   null: false
    t.text    "usrgrp_username", null: false
  end

  create_table "usrpref", primary_key: "usrpref_id", id: :integer, default: -> { "nextval(('usrpref_usrpref_id_seq'::text)::regclass)" }, force: :cascade, comment: "User Preferences information" do |t|
    t.text "usrpref_name"
    t.text "usrpref_value"
    t.text "usrpref_username"
    t.index ["usrpref_name"], name: "usrpref_userpref_name_idx", using: :btree
  end

  create_table "usrpriv", primary_key: "usrpriv_id", id: :integer, default: -> { "nextval(('usrpriv_usrpriv_id_seq'::text)::regclass)" }, force: :cascade, comment: "User Privileges information" do |t|
    t.integer "usrpriv_priv_id"
    t.text    "usrpriv_username"
  end

  create_table "usrsite", primary_key: "usrsite_id", force: :cascade, comment: "This is a specific site for a specific user." do |t|
    t.integer "usrsite_warehous_id", null: false
    t.text    "usrsite_username",    null: false
  end

  create_table "vendaddrinfo", primary_key: "vendaddr_id", id: :integer, default: -> { "nextval(('vendaddr_vendaddr_id_seq'::text)::regclass)" }, force: :cascade, comment: "Vendor Address information" do |t|
    t.integer "vendaddr_vend_id"
    t.text    "vendaddr_code"
    t.text    "vendaddr_name"
    t.text    "vendaddr_comments"
    t.integer "vendaddr_cntct_id"
    t.integer "vendaddr_addr_id"
    t.integer "vendaddr_taxzone_id"
  end

  create_table "vendinfo", primary_key: "vend_id", id: :integer, default: -> { "nextval(('vend_vend_id_seq'::text)::regclass)" }, force: :cascade, comment: "Vendor information" do |t|
    t.text    "vend_name"
    t.date    "vend_lastpurchdate"
    t.boolean "vend_active"
    t.boolean "vend_po"
    t.text    "vend_comments"
    t.text    "vend_pocomments"
    t.text    "vend_number",                                                      null: false
    t.boolean "vend_1099"
    t.boolean "vend_exported"
    t.string  "vend_fobsource",         limit: 1
    t.text    "vend_fob"
    t.integer "vend_terms_id"
    t.text    "vend_shipvia"
    t.integer "vend_vendtype_id"
    t.boolean "vend_qualified"
    t.text    "vend_ediemail"
    t.text    "vend_ediemailbody"
    t.text    "vend_edisubject"
    t.text    "vend_edifilename"
    t.text    "vend_accntnum"
    t.boolean "vend_emailpodelivery"
    t.boolean "vend_restrictpurch"
    t.text    "vend_edicc"
    t.integer "vend_curr_id",                     default: -> { "basecurrid()" }
    t.integer "vend_cntct1_id"
    t.integer "vend_cntct2_id"
    t.integer "vend_addr_id"
    t.boolean "vend_match",                       default: false,                 null: false
    t.boolean "vend_ach_enabled",                 default: false,                 null: false
    t.text    "vend_ach_accnttype",                                                            comment: "Type of bank account: K = checKing, C = Cash = savings. These values were chosen to be consistent with bankaccnt_type."
    t.boolean "vend_ach_use_vendinfo",            default: true,                  null: false
    t.text    "vend_ach_indiv_number",            default: "",                    null: false
    t.text    "vend_ach_indiv_name",              default: "",                    null: false
    t.boolean "vend_ediemailhtml",                default: false,                 null: false
    t.binary  "vend_ach_routingnumber",           default: "\x00",                null: false
    t.binary  "vend_ach_accntnumber",             default: "\x00",                null: false
    t.integer "vend_taxzone_id"
    t.integer "vend_accnt_id"
    t.integer "vend_expcat_id",                   default: -1
    t.integer "vend_tax_id",                      default: -1
    t.index ["vend_number"], name: "vend_number_idx", unique: true, using: :btree
    t.index ["vend_number"], name: "vendinfo_vend_number_key", unique: true, using: :btree
  end

  create_table "vendtype", primary_key: "vendtype_id", force: :cascade, comment: "Vendor Type information" do |t|
    t.text "vendtype_code",    null: false
    t.text "vendtype_descrip"
    t.index ["vendtype_code"], name: "vendtype_vendtype_code_key", unique: true, using: :btree
  end

  create_table "vodist", primary_key: "vodist_id", id: :integer, default: -> { "nextval(('\"vodist_vodist_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Voucher distribution information" do |t|
    t.integer "vodist_poitem_id"
    t.integer "vodist_vohead_id"
    t.integer "vodist_costelem_id"
    t.integer "vodist_accnt_id"
    t.decimal "vodist_amount",       precision: 18, scale: 6
    t.decimal "vodist_qty",          precision: 18, scale: 6
    t.integer "vodist_expcat_id",                             default: -1
    t.integer "vodist_tax_id",                                default: -1
    t.boolean "vodist_discountable",                          default: true, null: false
    t.text    "vodist_notes"
  end

  create_table "vohead", primary_key: "vohead_id", id: :integer, default: -> { "nextval(('vohead_vohead_id_seq'::text)::regclass)" }, force: :cascade, comment: "Voucher header information" do |t|
    t.text    "vohead_number",                                                                       null: false
    t.integer "vohead_pohead_id"
    t.boolean "vohead_posted"
    t.date    "vohead_duedate"
    t.text    "vohead_invcnumber"
    t.decimal "vohead_amount",              precision: 16, scale: 4
    t.date    "vohead_docdate"
    t.boolean "vohead_1099"
    t.date    "vohead_distdate"
    t.text    "vohead_reference"
    t.integer "vohead_terms_id"
    t.integer "vohead_vend_id"
    t.integer "vohead_curr_id",                                      default: -> { "basecurrid()" }
    t.integer "vohead_adjtaxtype_id"
    t.integer "vohead_freighttaxtype_id"
    t.date    "vohead_gldistdate"
    t.boolean "vohead_misc"
    t.integer "vohead_taxzone_id"
    t.integer "vohead_taxtype_id"
    t.text    "vohead_notes"
    t.integer "vohead_recurring_vohead_id"
    t.index ["vohead_number"], name: "vohead_vohead_number_key", unique: true, using: :btree
  end

  create_table "voheadtax", primary_key: "taxhist_id", id: :integer, default: -> { "nextval('taxhist_taxhist_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "taxhist_parent_id",                              null: false
    t.integer "taxhist_taxtype_id"
    t.integer "taxhist_tax_id",                                 null: false
    t.decimal "taxhist_basis",         precision: 16, scale: 2, null: false
    t.integer "taxhist_basis_tax_id"
    t.integer "taxhist_sequence"
    t.decimal "taxhist_percent",       precision: 10, scale: 6, null: false
    t.decimal "taxhist_amount",        precision: 16, scale: 2, null: false
    t.decimal "taxhist_tax",           precision: 16, scale: 6, null: false
    t.date    "taxhist_docdate",                                null: false
    t.date    "taxhist_distdate"
    t.integer "taxhist_curr_id"
    t.decimal "taxhist_curr_rate"
    t.integer "taxhist_journalnumber"
    t.index ["taxhist_parent_id", "taxhist_taxtype_id"], name: "voheadtax_taxhist_parent_type_idx", using: :btree
    t.index ["taxhist_parent_id"], name: "voheadtax_taxhist_parent_id_idx", using: :btree
    t.index ["taxhist_taxtype_id"], name: "voheadtax_taxhist_taxtype_id_idx", using: :btree
  end

  create_table "voitem", primary_key: "voitem_id", id: :integer, default: -> { "nextval(('\"voitem_voitem_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Voucher Line Item information" do |t|
    t.integer "voitem_vohead_id"
    t.integer "voitem_poitem_id"
    t.boolean "voitem_close"
    t.decimal "voitem_qty",        precision: 18, scale: 6
    t.decimal "voitem_freight",    precision: 16, scale: 4, default: "0.0", null: false
    t.integer "voitem_taxtype_id"
  end

  create_table "voitemtax", primary_key: "taxhist_id", id: :integer, default: -> { "nextval('taxhist_taxhist_id_seq'::regclass)" }, force: :cascade do |t|
    t.integer "taxhist_parent_id",                              null: false
    t.integer "taxhist_taxtype_id"
    t.integer "taxhist_tax_id",                                 null: false
    t.decimal "taxhist_basis",         precision: 16, scale: 2, null: false
    t.integer "taxhist_basis_tax_id"
    t.integer "taxhist_sequence"
    t.decimal "taxhist_percent",       precision: 10, scale: 6, null: false
    t.decimal "taxhist_amount",        precision: 16, scale: 2, null: false
    t.decimal "taxhist_tax",           precision: 16, scale: 6, null: false
    t.date    "taxhist_docdate",                                null: false
    t.date    "taxhist_distdate"
    t.integer "taxhist_curr_id"
    t.decimal "taxhist_curr_rate"
    t.integer "taxhist_journalnumber"
    t.index ["taxhist_parent_id", "taxhist_taxtype_id"], name: "voitemtax_taxhist_parent_type_idx", using: :btree
    t.index ["taxhist_parent_id"], name: "voitemtax_taxhist_parent_id_idx", using: :btree
    t.index ["taxhist_taxtype_id"], name: "voitemtax_taxhist_taxtype_id_idx", using: :btree
  end

  create_table "whsezone", primary_key: "whsezone_id", force: :cascade, comment: "Warehouse Zone information" do |t|
    t.integer "whsezone_warehous_id", null: false
    t.text    "whsezone_name",        null: false
    t.text    "whsezone_descrip"
  end

  create_table "whsinfo", primary_key: "warehous_id", id: :integer, default: -> { "nextval(('warehous_warehous_id_seq'::text)::regclass)" }, force: :cascade, comment: "Warehouse information" do |t|
    t.text    "warehous_code",                                                        null: false
    t.text    "warehous_descrip"
    t.text    "warehous_fob"
    t.boolean "warehous_active"
    t.text    "warehous_counttag_prefix"
    t.integer "warehous_counttag_number"
    t.text    "warehous_bol_prefix"
    t.integer "warehous_bol_number"
    t.boolean "warehous_shipping"
    t.boolean "warehous_useslips"
    t.boolean "warehous_usezones"
    t.integer "warehous_aislesize"
    t.boolean "warehous_aislealpha"
    t.integer "warehous_racksize"
    t.boolean "warehous_rackalpha"
    t.integer "warehous_binsize"
    t.boolean "warehous_binalpha"
    t.integer "warehous_locationsize"
    t.boolean "warehous_locationalpha"
    t.boolean "warehous_enforcearbl"
    t.integer "warehous_default_accnt_id"
    t.decimal "warehous_shipping_commission", precision: 8, scale: 4, default: "0.0"
    t.integer "warehous_cntct_id"
    t.integer "warehous_addr_id"
    t.boolean "warehous_transit",                                     default: false, null: false
    t.integer "warehous_shipform_id"
    t.integer "warehous_shipvia_id"
    t.text    "warehous_shipcomments"
    t.integer "warehous_costcat_id"
    t.integer "warehous_sitetype_id"
    t.integer "warehous_taxzone_id"
    t.integer "warehous_sequence",                                    default: 0,     null: false
    t.index ["warehous_code"], name: "warehous_code_key", using: :btree
    t.index ["warehous_code"], name: "whsinfo_warehous_code_key", unique: true, using: :btree
  end

  create_table "wo", primary_key: "wo_id", id: :integer, default: -> { "nextval(('wo_wo_id_seq'::text)::regclass)" }, force: :cascade, comment: "Work Order information" do |t|
    t.integer "wo_number"
    t.integer "wo_subnumber"
    t.string  "wo_status",         limit: 1
    t.integer "wo_itemsite_id"
    t.date    "wo_startdate"
    t.date    "wo_duedate"
    t.string  "wo_ordtype",        limit: 1
    t.integer "wo_ordid"
    t.decimal "wo_qtyord",                   precision: 18, scale: 6
    t.decimal "wo_qtyrcv",                   precision: 18, scale: 6
    t.boolean "wo_adhoc"
    t.integer "wo_itemcfg_series"
    t.boolean "wo_imported"
    t.decimal "wo_wipvalue",                 precision: 16, scale: 6, default: "0.0"
    t.decimal "wo_postedvalue",              precision: 16, scale: 6, default: "0.0"
    t.text    "wo_prodnotes"
    t.integer "wo_prj_id"
    t.integer "wo_priority",                                          default: 1,                             null: false
    t.decimal "wo_brdvalue",                 precision: 16, scale: 6, default: "0.0"
    t.integer "wo_bom_rev_id",                                        default: -1
    t.integer "wo_boo_rev_id",                                        default: -1
    t.string  "wo_cosmethod",      limit: 1
    t.integer "wo_womatl_id"
    t.text    "wo_username",                                          default: -> { "geteffectivextuser()" }
    t.index ["wo_duedate"], name: "wo_duedate", using: :btree
    t.index ["wo_itemsite_id"], name: "wo_itemsite_id", using: :btree
    t.index ["wo_ordtype"], name: "wo_ordtype", using: :btree
    t.index ["wo_startdate"], name: "wo_startdate", using: :btree
    t.index ["wo_status"], name: "wo_status", using: :btree
  end

  create_table "womatl", primary_key: "womatl_id", id: :integer, default: -> { "nextval(('womatl_womatl_id_seq'::text)::regclass)" }, force: :cascade, comment: "Work Order Material Requirements information" do |t|
    t.integer "womatl_wo_id"
    t.integer "womatl_itemsite_id"
    t.decimal "womatl_qtyper",                  precision: 20, scale: 8,                 null: false
    t.decimal "womatl_scrap",                   precision: 8,  scale: 4,                 null: false
    t.decimal "womatl_qtyreq",                  precision: 18, scale: 6,                 null: false
    t.decimal "womatl_qtyiss",                  precision: 18, scale: 6,                 null: false
    t.decimal "womatl_qtywipscrap",             precision: 18, scale: 6,                 null: false
    t.date    "womatl_lastissue"
    t.date    "womatl_lastreturn"
    t.decimal "womatl_cost",                    precision: 16, scale: 6
    t.boolean "womatl_picklist"
    t.string  "womatl_status",        limit: 1
    t.boolean "womatl_imported",                                         default: false
    t.boolean "womatl_createwo"
    t.string  "womatl_issuemethod",   limit: 1
    t.integer "womatl_wooper_id"
    t.integer "womatl_bomitem_id"
    t.date    "womatl_duedate"
    t.boolean "womatl_schedatwooper"
    t.integer "womatl_uom_id",                                                           null: false
    t.text    "womatl_notes"
    t.text    "womatl_ref"
    t.decimal "womatl_scrapvalue",              precision: 16, scale: 6, default: "0.0"
    t.decimal "womatl_qtyfxd",                  precision: 20, scale: 8, default: "0.0", null: false, comment: "The fixed quantity required"
    t.boolean "womatl_issuewo",                                          default: false, null: false
    t.decimal "womatl_price",                   precision: 16, scale: 6, default: "0.0", null: false
    t.index ["womatl_itemsite_id"], name: "womatl_itemsite_id_key", using: :btree
    t.index ["womatl_wo_id"], name: "womatl_wo_id_key", using: :btree
  end

  create_table "womatlpost", primary_key: "womatlpost_id", force: :cascade, comment: "Table to tie work order to work order material transactions for efficient queries" do |t|
    t.integer "womatlpost_womatl_id"
    t.integer "womatlpost_invhist_id"
    t.index ["womatlpost_womatl_id"], name: "womatlpost_womatl_id_idx", using: :btree
  end

  create_table "womatlvar", primary_key: "womatlvar_id", id: :integer, default: -> { "nextval(('\"womatlvar_womatlvar_id_seq\"'::text)::regclass)" }, force: :cascade, comment: "Work Order Material Requirements Variance information" do |t|
    t.integer "womatlvar_number"
    t.integer "womatlvar_subnumber"
    t.date    "womatlvar_posted"
    t.integer "womatlvar_parent_itemsite_id"
    t.integer "womatlvar_component_itemsite_id"
    t.decimal "womatlvar_qtyord",                precision: 18, scale: 6
    t.decimal "womatlvar_qtyrcv",                precision: 18, scale: 6
    t.decimal "womatlvar_qtyiss",                precision: 18, scale: 6
    t.decimal "womatlvar_qtyper",                precision: 18, scale: 6
    t.decimal "womatlvar_scrap",                 precision: 18, scale: 6
    t.decimal "womatlvar_wipscrap",              precision: 18, scale: 6
    t.integer "womatlvar_bomitem_id"
    t.text    "womatlvar_ref"
    t.text    "womatlvar_notes"
    t.decimal "womatlvar_qtyfxd",                precision: 20, scale: 8, default: "0.0", null: false, comment: "The fixed quantity required"
  end

  create_table "xsltmap", primary_key: "xsltmap_id", force: :cascade, comment: "Mapping of XML System identifiers to XSLT transformation files" do |t|
    t.text "xsltmap_name",                 null: false
    t.text "xsltmap_doctype",              null: false
    t.text "xsltmap_system",               null: false
    t.text "xsltmap_import",               null: false
    t.text "xsltmap_export",  default: "", null: false
    t.index ["xsltmap_name"], name: "xsltmap_name_key", unique: true, using: :btree
  end

  create_table "yearperiod", primary_key: "yearperiod_id", force: :cascade, comment: "Accounting Year Periods information" do |t|
    t.date    "yearperiod_start",                  null: false
    t.date    "yearperiod_end",                    null: false
    t.boolean "yearperiod_closed", default: false, null: false
  end

  add_foreign_key "accnt", "company", column: "accnt_company", primary_key: "company_number", name: "accnt_accnt_company_fkey", on_update: :cascade
  add_foreign_key "accnt", "curr_symbol", column: "accnt_curr_id", primary_key: "curr_id", name: "accnt_to_curr_symbol"
  add_foreign_key "apapply", "checkhead", column: "apapply_checkhead_id", primary_key: "checkhead_id", name: "apapply_apapply_checkhead_id_fkey"
  add_foreign_key "apapply", "curr_symbol", column: "apapply_curr_id", primary_key: "curr_id", name: "apapply_to_curr_symbol"
  add_foreign_key "apapply", "vendinfo", column: "apapply_vend_id", primary_key: "vend_id", name: "apapply_apapply_vend_id_fkey"
  add_foreign_key "apcreditapply", "curr_symbol", column: "apcreditapply_curr_id", primary_key: "curr_id", name: "apcreditapply_curr_symbol"
  add_foreign_key "apopen", "curr_symbol", column: "apopen_curr_id", primary_key: "curr_id", name: "apopen_to_curr_symbol"
  add_foreign_key "apopen", "vendinfo", column: "apopen_vend_id", primary_key: "vend_id", name: "apopen_apopen_vend_id_fkey"
  add_foreign_key "apopentax", "apopen", column: "taxhist_parent_id", primary_key: "apopen_id", name: "apopentax_taxhist_parent_id_fkey", on_delete: :cascade
  add_foreign_key "apopentax", "tax", column: "taxhist_basis_tax_id", primary_key: "tax_id", name: "apopentax_taxhist_basis_tax_id_fkey"
  add_foreign_key "apopentax", "tax", column: "taxhist_tax_id", primary_key: "tax_id", name: "apopentax_taxhist_tax_id_fkey"
  add_foreign_key "apopentax", "taxtype", column: "taxhist_taxtype_id", primary_key: "taxtype_id", name: "apopentax_taxhist_taxtype_id_fkey"
  add_foreign_key "apselect", "curr_symbol", column: "apselect_curr_id", primary_key: "curr_id", name: "apselect_to_curr_symbol"
  add_foreign_key "arapply", "curr_symbol", column: "arapply_curr_id", primary_key: "curr_id", name: "arapply_to_curr_symbol"
  add_foreign_key "arcreditapply", "curr_symbol", column: "arcreditapply_curr_id", primary_key: "curr_id", name: "arcreditapply_curr_symbol"
  add_foreign_key "aropen", "curr_symbol", column: "aropen_curr_id", primary_key: "curr_id", name: "aropen_to_curr_symbol"
  add_foreign_key "aropen", "custinfo", column: "aropen_cust_id", primary_key: "cust_id", name: "aropen_aropen_cust_id_fkey"
  add_foreign_key "aropen", "salesrep", column: "aropen_salesrep_id", primary_key: "salesrep_id", name: "aropen_aropen_salesrep_id_fkey"
  add_foreign_key "aropentax", "aropen", column: "taxhist_parent_id", primary_key: "aropen_id", name: "aropentax_taxhist_parent_id_fkey", on_delete: :cascade
  add_foreign_key "aropentax", "tax", column: "taxhist_basis_tax_id", primary_key: "tax_id", name: "aropentax_taxhist_basis_tax_id_fkey"
  add_foreign_key "aropentax", "tax", column: "taxhist_tax_id", primary_key: "tax_id", name: "aropentax_taxhist_tax_id_fkey"
  add_foreign_key "aropentax", "taxtype", column: "taxhist_taxtype_id", primary_key: "taxtype_id", name: "aropentax_taxhist_taxtype_id_fkey"
  add_foreign_key "asohist", "curr_symbol", column: "asohist_curr_id", primary_key: "curr_id", name: "asohist_to_curr_symbol"
  add_foreign_key "asohist", "taxtype", column: "asohist_taxtype_id", primary_key: "taxtype_id", name: "asohist_asohist_taxtype_id_fkey"
  add_foreign_key "asohist", "taxzone", column: "asohist_taxzone_id", primary_key: "taxzone_id", name: "asohist_asohist_taxzone_id_fkey"
  add_foreign_key "asohisttax", "asohist", column: "taxhist_parent_id", primary_key: "asohist_id", name: "asohisttax_taxhist_parent_id_fkey", on_delete: :cascade
  add_foreign_key "asohisttax", "tax", column: "taxhist_basis_tax_id", primary_key: "tax_id", name: "asohisttax_taxhist_basis_tax_id_fkey"
  add_foreign_key "asohisttax", "tax", column: "taxhist_tax_id", primary_key: "tax_id", name: "asohisttax_taxhist_tax_id_fkey"
  add_foreign_key "asohisttax", "taxtype", column: "taxhist_taxtype_id", primary_key: "taxtype_id", name: "asohisttax_taxhist_taxtype_id_fkey"
  add_foreign_key "bankaccnt", "curr_symbol", column: "bankaccnt_curr_id", primary_key: "curr_id", name: "bankaccnt_to_curr_symbol"
  add_foreign_key "bankadj", "curr_symbol", column: "bankadj_curr_id", primary_key: "curr_id", name: "bankadj_to_curr_symbol"
  add_foreign_key "bomhead", "item", column: "bomhead_item_id", primary_key: "item_id", name: "bomhead_bomhead_item_id_fkey", on_update: :restrict, on_delete: :cascade
  add_foreign_key "bomhist", "\"char\"", column: "bomhist_char_id", primary_key: "char_id", name: "bomhist_bomhist_char_id_fkey"
  add_foreign_key "bomitem", "\"char\"", column: "bomitem_char_id", primary_key: "char_id", name: "bomitem_bomitem_char_id_fkey"
  add_foreign_key "bomitem", "item", column: "bomitem_item_id", primary_key: "item_id", name: "bomitem_bomitem_item_id_fkey"
  add_foreign_key "bomitem", "item", column: "bomitem_parent_item_id", primary_key: "item_id", name: "bomitem_bomitem_parent_item_id_fkey", on_update: :restrict, on_delete: :cascade
  add_foreign_key "bomitem", "uom", column: "bomitem_uom_id", primary_key: "uom_id", name: "bomitem_bomitem_uom_id_fkey"
  add_foreign_key "bomitemcost", "bomitem", column: "bomitemcost_bomitem_id", primary_key: "bomitem_id", name: "bomitemcost_bomitemcost_bomitem_id_fkey"
  add_foreign_key "bomitemcost", "costelem", column: "bomitemcost_costelem_id", primary_key: "costelem_id", name: "bomitemcost_bomitemcost_costelem_id_fkey"
  add_foreign_key "bomitemcost", "curr_symbol", column: "bomitemcost_curr_id", primary_key: "curr_id", name: "bomitemcost_bomitemcost_curr_id_fkey"
  add_foreign_key "bomitemsub", "bomitem", column: "bomitemsub_bomitem_id", primary_key: "bomitem_id", name: "bomitemsub_bomitemsub_bomitem_id_fkey", on_update: :restrict, on_delete: :cascade
  add_foreign_key "bomitemsub", "item", column: "bomitemsub_item_id", primary_key: "item_id", name: "bomitemsub_bomitemsub_item_id_fkey", on_update: :restrict, on_delete: :cascade
  add_foreign_key "bomwork", "\"char\"", column: "bomwork_char_id", primary_key: "char_id", name: "bomwork_bomwork_char_id_fkey"
  add_foreign_key "budgitem", "budghead", column: "budgitem_budghead_id", primary_key: "budghead_id", name: "budgitem_budgitem_budghead_id_fkey"
  add_foreign_key "budgitem", "period", column: "budgitem_period_id", primary_key: "period_id", name: "budgitem_budgitem_period_id_fkey"
  add_foreign_key "cashrcpt", "bankaccnt", column: "cashrcpt_bankaccnt_id", primary_key: "bankaccnt_id", name: "cashrcpt_bankaccnt_bankaccnt_id_fkey"
  add_foreign_key "cashrcpt", "curr_symbol", column: "cashrcpt_curr_id", primary_key: "curr_id", name: "cashrcpt_to_curr_symbol"
  add_foreign_key "cashrcpt", "custinfo", column: "cashrcpt_cust_id", primary_key: "cust_id", name: "cashrcpt_cust_cust_id_fkey"
  add_foreign_key "cashrcptitem", "aropen", column: "cashrcptitem_aropen_id", primary_key: "aropen_id", name: "cashrcptitem_aropen_aropen_id_fkey"
  add_foreign_key "cashrcptitem", "cashrcpt", column: "cashrcptitem_cashrcpt_id", primary_key: "cashrcpt_id", name: "cashrcptitem_cashrcpt_cashrcpt_id_fkey"
  add_foreign_key "cashrcptmisc", "accnt", column: "cashrcptmisc_accnt_id", primary_key: "accnt_id", name: "cashrcptmisc_accnt_accnt_id_fkey"
  add_foreign_key "cashrcptmisc", "cashrcpt", column: "cashrcptmisc_cashrcpt_id", primary_key: "cashrcpt_id", name: "cashrcptmisc_cashrcpt_cashrcpt_id_fkey"
  add_foreign_key "ccard", "custinfo", column: "ccard_cust_id", primary_key: "cust_id", name: "ccard_ccard_cust_id_fkey"
  add_foreign_key "ccbank", "bankaccnt", column: "ccbank_bankaccnt_id", primary_key: "bankaccnt_id", name: "ccbank_ccbank_bankaccnt_id_fkey"
  add_foreign_key "charopt", "\"char\"", column: "charopt_char_id", primary_key: "char_id", name: "charopt_charopt_char_id_fkey", on_delete: :cascade
  add_foreign_key "charuse", "\"char\"", column: "charuse_char_id", primary_key: "char_id", name: "charuse_charuse_char_id_fkey", on_delete: :cascade
  add_foreign_key "checkhead", "bankaccnt", column: "checkhead_bankaccnt_id", primary_key: "bankaccnt_id", name: "checkhead_checkhead_bankaccnt_id_fkey"
  add_foreign_key "checkhead", "curr_symbol", column: "checkhead_curr_id", primary_key: "curr_id", name: "checkhead_checkhead_curr_id_fkey"
  add_foreign_key "checkhead", "expcat", column: "checkhead_expcat_id", primary_key: "expcat_id", name: "checkhead_checkhead_expcat_id_fkey"
  add_foreign_key "checkitem", "apopen", column: "checkitem_apopen_id", primary_key: "apopen_id", name: "checkitem_checkitem_apopen_id_fkey"
  add_foreign_key "checkitem", "aropen", column: "checkitem_aropen_id", primary_key: "aropen_id", name: "checkitem_checkitem_aropen_id_fkey"
  add_foreign_key "checkitem", "checkhead", column: "checkitem_checkhead_id", primary_key: "checkhead_id", name: "checkitem_checkitem_checkhead_id_fkey"
  add_foreign_key "checkitem", "curr_symbol", column: "checkitem_curr_id", primary_key: "curr_id", name: "checkitem_checkitem_curr_id_fkey"
  add_foreign_key "cmdarg", "cmd", column: "cmdarg_cmd_id", primary_key: "cmd_id", name: "cmdarg_cmdarg_cmd_id_fkey", on_delete: :cascade
  add_foreign_key "cmhead", "curr_symbol", column: "cmhead_curr_id", primary_key: "curr_id", name: "cmhead_to_curr_symbol"
  add_foreign_key "cmhead", "custinfo", column: "cmhead_cust_id", primary_key: "cust_id", name: "cmhead_cmhead_cust_id_fkey"
  add_foreign_key "cmhead", "prj", column: "cmhead_prj_id", primary_key: "prj_id", name: "cmhead_cmhead_prj_id_fkey"
  add_foreign_key "cmhead", "salesrep", column: "cmhead_salesrep_id", primary_key: "salesrep_id", name: "cmhead_cmhead_salesrep_id_fkey"
  add_foreign_key "cmhead", "saletype", column: "cmhead_saletype_id", primary_key: "saletype_id", name: "cmhead_cmhead_saletype_id_fkey"
  add_foreign_key "cmhead", "shipzone", column: "cmhead_shipzone_id", primary_key: "shipzone_id", name: "cmhead_cmhead_shipzone_id_fkey"
  add_foreign_key "cmhead", "taxtype", column: "cmhead_freighttaxtype_id", primary_key: "taxtype_id", name: "cmhead_cmhead_freighttaxtype_id_fkey"
  add_foreign_key "cmhead", "taxzone", column: "cmhead_taxzone_id", primary_key: "taxzone_id", name: "cmhead_cmhead_taxzone_id_fkey"
  add_foreign_key "cmheadtax", "cmhead", column: "taxhist_parent_id", primary_key: "cmhead_id", name: "cmheadtax_taxhist_parent_id_fkey", on_delete: :cascade
  add_foreign_key "cmheadtax", "tax", column: "taxhist_basis_tax_id", primary_key: "tax_id", name: "cmheadtax_taxhist_basis_tax_id_fkey"
  add_foreign_key "cmheadtax", "tax", column: "taxhist_tax_id", primary_key: "tax_id", name: "cmheadtax_taxhist_tax_id_fkey"
  add_foreign_key "cmheadtax", "taxtype", column: "taxhist_taxtype_id", primary_key: "taxtype_id", name: "cmheadtax_taxhist_taxtype_id_fkey"
  add_foreign_key "cmitem", "cmhead", column: "cmitem_cmhead_id", primary_key: "cmhead_id", name: "cmitem_cmhead_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "cmitem", "taxtype", column: "cmitem_taxtype_id", primary_key: "taxtype_id", name: "cmitem_cmitem_taxtype_id_fkey"
  add_foreign_key "cmitem", "uom", column: "cmitem_price_uom_id", primary_key: "uom_id", name: "cmitem_cmitem_price_uom_id_fkey"
  add_foreign_key "cmitem", "uom", column: "cmitem_qty_uom_id", primary_key: "uom_id", name: "cmitem_cmitem_qty_uom_id_fkey"
  add_foreign_key "cmitemtax", "cmitem", column: "taxhist_parent_id", primary_key: "cmitem_id", name: "cmitemtax_taxhist_parent_id_fkey", on_delete: :cascade
  add_foreign_key "cmitemtax", "tax", column: "taxhist_basis_tax_id", primary_key: "tax_id", name: "cmitemtax_taxhist_basis_tax_id_fkey"
  add_foreign_key "cmitemtax", "tax", column: "taxhist_tax_id", primary_key: "tax_id", name: "cmitemtax_taxhist_tax_id_fkey"
  add_foreign_key "cmitemtax", "taxtype", column: "taxhist_taxtype_id", primary_key: "taxtype_id", name: "cmitemtax_taxhist_taxtype_id_fkey"
  add_foreign_key "cmnttypesource", "cmnttype", column: "cmnttypesource_cmnttype_id", primary_key: "cmnttype_id", name: "cmnttypesource_cmnttypesource_cmnttype_id_fkey"
  add_foreign_key "cmnttypesource", "source", column: "cmnttypesource_source_id", primary_key: "source_id", name: "cmnttypesource_cmnttypesource_source_id_fkey"
  add_foreign_key "cntct", "addr", column: "cntct_addr_id", primary_key: "addr_id", name: "cntct_cntct_addr_id_fkey"
  add_foreign_key "cntct", "crmacct", column: "cntct_crmacct_id", primary_key: "crmacct_id", name: "cntct_cntct_crmacct_id_fkey"
  add_foreign_key "cntctaddr", "addr", column: "cntctaddr_addr_id", primary_key: "addr_id", name: "cntctaddr_cntctaddr_addr_id_fkey"
  add_foreign_key "cntctaddr", "cntct", column: "cntctaddr_cntct_id", primary_key: "cntct_id", name: "cntctaddr_cntctaddr_cntct_id_fkey", on_delete: :cascade
  add_foreign_key "cntctdata", "cntct", column: "cntctdata_cntct_id", primary_key: "cntct_id", name: "cntctdata_cntctdata_cntct_id_fkey", on_delete: :cascade
  add_foreign_key "cntcteml", "cntct", column: "cntcteml_cntct_id", primary_key: "cntct_id", name: "cntcteml_cntcteml_cntct_id_fkey", on_delete: :cascade
  add_foreign_key "cntctmrgd", "cntct", column: "cntctmrgd_cntct_id", primary_key: "cntct_id", name: "cntctmrgd_cntctmrgd_cntct_id_fkey", on_delete: :cascade
  add_foreign_key "cntctsel", "cntct", column: "cntctsel_cntct_id", primary_key: "cntct_id", name: "cntctsel_cntctsel_cntct_id_fkey", on_delete: :cascade
  add_foreign_key "cobill", "invcitem", column: "cobill_invcitem_id", primary_key: "invcitem_id", name: "cobill_cobill_invcitem_id_fkey"
  add_foreign_key "cobill", "taxtype", column: "cobill_taxtype_id", primary_key: "taxtype_id", name: "cobill_cobill_taxtype_id_fkey"
  add_foreign_key "cobilltax", "cobill", column: "taxhist_parent_id", primary_key: "cobill_id", name: "cobilltax_taxhist_parent_id_fkey", on_delete: :cascade
  add_foreign_key "cobilltax", "tax", column: "taxhist_basis_tax_id", primary_key: "tax_id", name: "cobilltax_taxhist_basis_tax_id_fkey"
  add_foreign_key "cobilltax", "tax", column: "taxhist_tax_id", primary_key: "tax_id", name: "cobilltax_taxhist_tax_id_fkey"
  add_foreign_key "cobilltax", "taxtype", column: "taxhist_taxtype_id", primary_key: "taxtype_id", name: "cobilltax_taxhist_taxtype_id_fkey"
  add_foreign_key "cobmisc", "curr_symbol", column: "cobmisc_curr_id", primary_key: "curr_id", name: "cobmisc_to_curr_symbol"
  add_foreign_key "cobmisc", "invchead", column: "cobmisc_invchead_id", primary_key: "invchead_id", name: "cobmisc_cobmisc_invchead_id_fkey"
  add_foreign_key "cobmisc", "taxtype", column: "cobmisc_taxtype_id", primary_key: "taxtype_id", name: "cobmisc_cobmisc_taxtype_id_fkey"
  add_foreign_key "cobmisc", "taxzone", column: "cobmisc_taxzone_id", primary_key: "taxzone_id", name: "cobmisc_cobmisc_taxzone_id_fkey"
  add_foreign_key "cobmisctax", "cobmisc", column: "taxhist_parent_id", primary_key: "cobmisc_id", name: "cobmisctax_taxhist_parent_id_fkey", on_delete: :cascade
  add_foreign_key "cobmisctax", "tax", column: "taxhist_basis_tax_id", primary_key: "tax_id", name: "cobmisctax_taxhist_basis_tax_id_fkey"
  add_foreign_key "cobmisctax", "tax", column: "taxhist_tax_id", primary_key: "tax_id", name: "cobmisctax_taxhist_tax_id_fkey"
  add_foreign_key "cobmisctax", "taxtype", column: "taxhist_taxtype_id", primary_key: "taxtype_id", name: "cobmisctax_taxhist_taxtype_id_fkey"
  add_foreign_key "cohead", "accnt", column: "cohead_misc_accnt_id", primary_key: "accnt_id", name: "cohead_cohead_misc_accnt_id_fkey"
  add_foreign_key "cohead", "cntct", column: "cohead_billto_cntct_id", primary_key: "cntct_id", name: "cohead_cohead_billto_cntct_id_fkey"
  add_foreign_key "cohead", "cntct", column: "cohead_shipto_cntct_id", primary_key: "cntct_id", name: "cohead_cohead_shipto_cntct_id_fkey"
  add_foreign_key "cohead", "curr_symbol", column: "cohead_curr_id", primary_key: "curr_id", name: "cohead_to_curr_symbol"
  add_foreign_key "cohead", "custinfo", column: "cohead_cust_id", primary_key: "cust_id", name: "cohead_cohead_cust_id_fkey"
  add_foreign_key "cohead", "ophead", column: "cohead_ophead_id", primary_key: "ophead_id", name: "cohead_cohead_ophead_id_fkey"
  add_foreign_key "cohead", "prj", column: "cohead_prj_id", primary_key: "prj_id", name: "cohead_cohead_prj_id_fkey"
  add_foreign_key "cohead", "salesrep", column: "cohead_salesrep_id", primary_key: "salesrep_id", name: "cohead_cohead_salesrep_id_fkey"
  add_foreign_key "cohead", "saletype", column: "cohead_saletype_id", primary_key: "saletype_id", name: "cohead_cohead_saletype_id_fkey"
  add_foreign_key "cohead", "shipform", column: "cohead_shipform_id", primary_key: "shipform_id", name: "cohead_cohead_shipform_id_fkey"
  add_foreign_key "cohead", "shiptoinfo", column: "cohead_shipto_id", primary_key: "shipto_id", name: "cohead_cohead_shipto_id_fkey"
  add_foreign_key "cohead", "shipzone", column: "cohead_shipzone_id", primary_key: "shipzone_id", name: "cohead_cohead_shipzone_id_fkey"
  add_foreign_key "cohead", "taxtype", column: "cohead_taxtype_id", primary_key: "taxtype_id", name: "cohead_cohead_taxtype_id_fkey"
  add_foreign_key "cohead", "taxzone", column: "cohead_taxzone_id", primary_key: "taxzone_id", name: "cohead_cohead_taxzone_id_fkey"
  add_foreign_key "cohead", "terms", column: "cohead_terms_id", primary_key: "terms_id", name: "cohead_cohead_terms_id_fkey"
  add_foreign_key "cohead", "whsinfo", column: "cohead_warehous_id", primary_key: "warehous_id", name: "cohead_cohead_warehous_id_fkey"
  add_foreign_key "cohist", "ccpay", column: "cohist_cohead_ccpay_id", primary_key: "ccpay_id", name: "cohist_cohist_cohead_ccpay_id_fkey"
  add_foreign_key "cohist", "curr_symbol", column: "cohist_curr_id", primary_key: "curr_id", name: "cohist_to_curr_symbol"
  add_foreign_key "cohist", "custinfo", column: "cohist_cust_id", primary_key: "cust_id", name: "cohist_cohist_cust_id_fkey"
  add_foreign_key "cohist", "salesrep", column: "cohist_salesrep_id", primary_key: "salesrep_id", name: "cohist_cohist_salesrep_id_fkey"
  add_foreign_key "cohist", "taxtype", column: "cohist_taxtype_id", primary_key: "taxtype_id", name: "cohist_cohist_taxtype_id_fkey"
  add_foreign_key "cohist", "taxzone", column: "cohist_taxzone_id", primary_key: "taxzone_id", name: "cohist_cohist_taxzone_id_fkey"
  add_foreign_key "cohisttax", "cohist", column: "taxhist_parent_id", primary_key: "cohist_id", name: "cohisttax_taxhist_parent_id_fkey", on_delete: :cascade
  add_foreign_key "cohisttax", "tax", column: "taxhist_basis_tax_id", primary_key: "tax_id", name: "cohisttax_taxhist_basis_tax_id_fkey"
  add_foreign_key "cohisttax", "tax", column: "taxhist_tax_id", primary_key: "tax_id", name: "cohisttax_taxhist_tax_id_fkey"
  add_foreign_key "cohisttax", "taxtype", column: "taxhist_taxtype_id", primary_key: "taxtype_id", name: "cohisttax_taxhist_taxtype_id_fkey"
  add_foreign_key "coitem", "accnt", column: "coitem_cos_accnt_id", primary_key: "accnt_id", name: "coitem_coitem_cos_accnt_id_fkey"
  add_foreign_key "coitem", "accnt", column: "coitem_rev_accnt_id", primary_key: "accnt_id", name: "coitem_coitem_rev_accnt_id_fkey"
  add_foreign_key "coitem", "cohead", column: "coitem_cohead_id", primary_key: "cohead_id", name: "coitem_coitem_cohead_id_fkey", on_delete: :cascade
  add_foreign_key "coitem", "item", column: "coitem_substitute_item_id", primary_key: "item_id", name: "coitem_coitem_substitute_item_id_fkey"
  add_foreign_key "coitem", "itemsite", column: "coitem_itemsite_id", primary_key: "itemsite_id", name: "coitem_coitem_itemsite_id_fkey"
  add_foreign_key "coitem", "taxtype", column: "coitem_taxtype_id", primary_key: "taxtype_id", name: "coitem_coitem_taxtype_id_fkey"
  add_foreign_key "coitem", "uom", column: "coitem_price_uom_id", primary_key: "uom_id", name: "coitem_coitem_price_uom_id_fkey"
  add_foreign_key "coitem", "uom", column: "coitem_qty_uom_id", primary_key: "uom_id", name: "coitem_coitem_qty_uom_id_fkey"
  add_foreign_key "coitem", "uom", column: "coitem_qtyreserved_uom_id", primary_key: "uom_id", name: "coitem_coitem_qtyreserved_uom_id_fkey"
  add_foreign_key "comment", "cmnttype", column: "comment_cmnttype_id", primary_key: "cmnttype_id", name: "comment_comment_cmnttype_id_fkey"
  add_foreign_key "company", "accnt", column: "company_dscrp_accnt_id", primary_key: "accnt_id", name: "company_company_dscrp_accnt_id_fkey"
  add_foreign_key "company", "accnt", column: "company_gainloss_accnt_id", primary_key: "accnt_id", name: "company_company_gainloss_accnt_id_fkey"
  add_foreign_key "company", "accnt", column: "company_unrlzgainloss_accnt_id", primary_key: "accnt_id", name: "company_company_unrlzgainloss_accnt_id_fkey"
  add_foreign_key "company", "accnt", column: "company_yearend_accnt_id", primary_key: "accnt_id", name: "company_company_yearend_accnt_id_fkey"
  add_foreign_key "company", "curr_symbol", column: "company_curr_id", primary_key: "curr_id", name: "company_company_curr_id_fkey"
  add_foreign_key "contrct", "vendinfo", column: "contrct_vend_id", primary_key: "vend_id", name: "contrct_contrct_vend_id_fkey"
  add_foreign_key "costhist", "curr_symbol", column: "costhist_newcurr_id", primary_key: "curr_id", name: "costhist_new_to_curr_symbol"
  add_foreign_key "costhist", "curr_symbol", column: "costhist_oldcurr_id", primary_key: "curr_id", name: "costhist_old_to_curr_symbol"
  add_foreign_key "crmacct", "cntct", column: "crmacct_cntct_id_1", primary_key: "cntct_id", name: "crmacct_crmacct_cntct_id_1_fkey"
  add_foreign_key "crmacct", "cntct", column: "crmacct_cntct_id_2", primary_key: "cntct_id", name: "crmacct_crmacct_cntct_id_2_fkey"
  add_foreign_key "crmacct", "crmacct", column: "crmacct_parent_id", primary_key: "crmacct_id", name: "crmacct_crmacct_parent_id_fkey"
  add_foreign_key "crmacct", "custinfo", column: "crmacct_cust_id", primary_key: "cust_id", name: "crmacct_crmacct_cust_id_fkey"
  add_foreign_key "crmacct", "emp", column: "crmacct_emp_id", primary_key: "emp_id", name: "crmacct_crmacct_emp_id_fkey"
  add_foreign_key "crmacct", "prospect", column: "crmacct_prospect_id", primary_key: "prospect_id", name: "crmacct_crmacct_prospect_id_fkey"
  add_foreign_key "crmacct", "salesrep", column: "crmacct_salesrep_id", primary_key: "salesrep_id", name: "crmacct_crmacct_salesrep_id_fkey"
  add_foreign_key "crmacct", "taxauth", column: "crmacct_taxauth_id", primary_key: "taxauth_id", name: "crmacct_crmacct_taxauth_id_fkey"
  add_foreign_key "crmacct", "vendinfo", column: "crmacct_vend_id", primary_key: "vend_id", name: "crmacct_crmacct_vend_id_fkey"
  add_foreign_key "crmacctsel", "crmacct", column: "crmacctsel_dest_crmacct_id", primary_key: "crmacct_id", name: "crmacctsel_crmacctsel_dest_crmacct_id_fkey", on_delete: :cascade
  add_foreign_key "crmacctsel", "crmacct", column: "crmacctsel_src_crmacct_id", primary_key: "crmacct_id", name: "crmacctsel_crmacctsel_src_crmacct_id_fkey", on_delete: :cascade
  add_foreign_key "curr_rate", "curr_symbol", column: "curr_id", primary_key: "curr_id", name: "curr_rate_to_curr_symbol"
  add_foreign_key "custinfo", "cntct", column: "cust_cntct_id", primary_key: "cntct_id", name: "custinfo_cust_cntct_id_fkey"
  add_foreign_key "custinfo", "cntct", column: "cust_corrcntct_id", primary_key: "cntct_id", name: "custinfo_cust_corrcntct_id_fkey"
  add_foreign_key "custinfo", "curr_symbol", column: "cust_creditlmt_curr_id", primary_key: "curr_id", name: "cust_creditlmt_to_curr_symbol"
  add_foreign_key "custinfo", "curr_symbol", column: "cust_curr_id", primary_key: "curr_id", name: "cust_to_curr_symbol"
  add_foreign_key "custinfo", "custtype", column: "cust_custtype_id", primary_key: "custtype_id", name: "custinfo_cust_custtype_fkey", on_update: :restrict, on_delete: :restrict
  add_foreign_key "custinfo", "salesrep", column: "cust_salesrep_id", primary_key: "salesrep_id", name: "custinfo_cust_salesrep_fkey", on_update: :restrict, on_delete: :restrict
  add_foreign_key "custinfo", "shipform", column: "cust_shipform_id", primary_key: "shipform_id", name: "custinfo_cust_shipform_fkey", on_update: :restrict, on_delete: :restrict
  add_foreign_key "custinfo", "taxzone", column: "cust_taxzone_id", primary_key: "taxzone_id", name: "custinfo_cust_taxzone_id_fkey"
  add_foreign_key "custinfo", "terms", column: "cust_terms_id", primary_key: "terms_id", name: "custinfo_cust_terms_fkey", on_update: :restrict, on_delete: :restrict
  add_foreign_key "emp", "cntct", column: "emp_cntct_id", primary_key: "cntct_id", name: "emp_emp_cntct_id_fkey"
  add_foreign_key "emp", "curr_symbol", column: "emp_wage_curr_id", primary_key: "curr_id", name: "emp_emp_wage_curr_id_fkey"
  add_foreign_key "emp", "dept", column: "emp_dept_id", primary_key: "dept_id", name: "emp_emp_dept_id_fkey"
  add_foreign_key "emp", "emp", column: "emp_mgr_emp_id", primary_key: "emp_id", name: "emp_emp_mgr_emp_id_fkey"
  add_foreign_key "emp", "image", column: "emp_image_id", primary_key: "image_id", name: "emp_emp_image_id_fkey"
  add_foreign_key "emp", "shift", column: "emp_shift_id", primary_key: "shift_id", name: "emp_emp_shift_id_fkey"
  add_foreign_key "emp", "whsinfo", column: "emp_warehous_id", primary_key: "warehous_id", name: "emp_emp_warehous_id_fkey"
  add_foreign_key "empgrpitem", "emp", column: "empgrpitem_emp_id", primary_key: "emp_id", name: "empgrpitem_empgrpitem_emp_id_fkey"
  add_foreign_key "empgrpitem", "empgrp", column: "empgrpitem_empgrp_id", primary_key: "empgrp_id", name: "empgrpitem_empgrpitem_empgrp_id_fkey"
  add_foreign_key "examples", "users"
  add_foreign_key "flnotes", "flhead", column: "flnotes_flhead_id", primary_key: "flhead_id", name: "flnotes_flnotes_flhead_id_fkey", on_delete: :cascade
  add_foreign_key "flnotes", "period", column: "flnotes_period_id", primary_key: "period_id", name: "flnotes_flnotes_period_id_fkey", on_delete: :cascade
  add_foreign_key "gltranssync", "company", column: "gltranssync_company_id", primary_key: "company_id", name: "gltranssync_gltranssync_company_id_fkey"
  add_foreign_key "gltranssync", "curr_symbol", column: "gltranssync_curr_id", primary_key: "curr_id", name: "gltranssync_gltranssync_curr_id_fkey"
  add_foreign_key "gltranssync", "period", column: "gltranssync_period_id", primary_key: "period_id", name: "gltranssync_gltranssync_period_id_fkey"
  add_foreign_key "grppriv", "grp", column: "grppriv_grp_id", primary_key: "grp_id", name: "grppriv_grppriv_grp_id_fkey"
  add_foreign_key "incdt", "aropen", column: "incdt_aropen_id", primary_key: "aropen_id", name: "incdt_incdt_aropen_id_fkey"
  add_foreign_key "incdt", "cntct", column: "incdt_cntct_id", primary_key: "cntct_id", name: "incdt_incdt_cntct_id_fkey"
  add_foreign_key "incdt", "crmacct", column: "incdt_crmacct_id", primary_key: "crmacct_id", name: "incdt_incdt_crmacct_id_fkey"
  add_foreign_key "incdt", "incdt", column: "incdt_recurring_incdt_id", primary_key: "incdt_id", name: "incdt_incdt_recurring_incdt_id_fkey"
  add_foreign_key "incdt", "incdtcat", column: "incdt_incdtcat_id", primary_key: "incdtcat_id", name: "incdt_incdt_incdtcat_id_fkey"
  add_foreign_key "incdt", "incdtpriority", column: "incdt_incdtpriority_id", primary_key: "incdtpriority_id", name: "incdt_incdt_incdtpriority_id_fkey"
  add_foreign_key "incdt", "incdtresolution", column: "incdt_incdtresolution_id", primary_key: "incdtresolution_id", name: "incdt_incdt_incdtresolution_id_fkey"
  add_foreign_key "incdt", "incdtseverity", column: "incdt_incdtseverity_id", primary_key: "incdtseverity_id", name: "incdt_incdt_incdtseverity_id_fkey"
  add_foreign_key "incdt", "item", column: "incdt_item_id", primary_key: "item_id", name: "incdt_incdt_item_id_fkey"
  add_foreign_key "incdt", "ls", column: "incdt_ls_id", primary_key: "ls_id", name: "incdt_incdt_ls_id_fkey"
  add_foreign_key "incdt", "prj", column: "incdt_prj_id", primary_key: "prj_id", name: "incdt_incdt_prj_id_fkey"
  add_foreign_key "incdthist", "incdt", column: "incdthist_incdt_id", primary_key: "incdt_id", name: "incdthist_incdthist_incdt_id_fkey"
  add_foreign_key "invbal", "itemsite", column: "invbal_itemsite_id", primary_key: "itemsite_id", name: "invbal_invbal_itemsite_id_fkey", on_delete: :cascade
  add_foreign_key "invbal", "period", column: "invbal_period_id", primary_key: "period_id", name: "invbal_invbal_period_id_fkey", on_delete: :cascade
  add_foreign_key "invchead", "curr_symbol", column: "invchead_curr_id", primary_key: "curr_id", name: "invchead_to_curr_symbol"
  add_foreign_key "invchead", "saletype", column: "invchead_saletype_id", primary_key: "saletype_id", name: "invchead_invchead_saletype_id_fkey"
  add_foreign_key "invchead", "shipzone", column: "invchead_shipzone_id", primary_key: "shipzone_id", name: "invchead_invchead_shipzone_id_fkey"
  add_foreign_key "invchead", "taxzone", column: "invchead_taxzone_id", primary_key: "taxzone_id", name: "invchead_invchead_taxzone_id_fkey"
  add_foreign_key "invcheadtax", "invchead", column: "taxhist_parent_id", primary_key: "invchead_id", name: "invcheadtax_taxhist_parent_id_fkey", on_delete: :cascade
  add_foreign_key "invcheadtax", "tax", column: "taxhist_basis_tax_id", primary_key: "tax_id", name: "invcheadtax_taxhist_basis_tax_id_fkey"
  add_foreign_key "invcheadtax", "tax", column: "taxhist_tax_id", primary_key: "tax_id", name: "invcheadtax_taxhist_tax_id_fkey"
  add_foreign_key "invcheadtax", "taxtype", column: "taxhist_taxtype_id", primary_key: "taxtype_id", name: "invcheadtax_taxhist_taxtype_id_fkey"
  add_foreign_key "invcitem", "accnt", column: "invcitem_rev_accnt_id", primary_key: "accnt_id", name: "invcitem_invcitem_rev_accnt_id_fkey"
  add_foreign_key "invcitem", "invchead", column: "invcitem_invchead_id", primary_key: "invchead_id", name: "invcitem_invchead_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "invcitem", "taxtype", column: "invcitem_taxtype_id", primary_key: "taxtype_id", name: "invcitem_invcitem_taxtype_id_fkey"
  add_foreign_key "invcitem", "uom", column: "invcitem_price_uom_id", primary_key: "uom_id", name: "invcitem_invcitem_price_uom_id_fkey"
  add_foreign_key "invcitem", "uom", column: "invcitem_qty_uom_id", primary_key: "uom_id", name: "invcitem_invcitem_qty_uom_id_fkey"
  add_foreign_key "invcitemtax", "invcitem", column: "taxhist_parent_id", primary_key: "invcitem_id", name: "invcitemtax_taxhist_parent_id_fkey", on_delete: :cascade
  add_foreign_key "invcitemtax", "tax", column: "taxhist_basis_tax_id", primary_key: "tax_id", name: "invcitemtax_taxhist_basis_tax_id_fkey"
  add_foreign_key "invcitemtax", "tax", column: "taxhist_tax_id", primary_key: "tax_id", name: "invcitemtax_taxhist_tax_id_fkey"
  add_foreign_key "invcitemtax", "taxtype", column: "taxhist_taxtype_id", primary_key: "taxtype_id", name: "invcitemtax_taxhist_taxtype_id_fkey"
  add_foreign_key "invdetail", "ls", column: "invdetail_ls_id", primary_key: "ls_id", name: "invdetail_invdetail_ls_id_fkey"
  add_foreign_key "invhistexpcat", "expcat", column: "invhistexpcat_expcat_id", primary_key: "expcat_id", name: "invhistexpcat_invhistexpcat_expcat_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "invhistexpcat", "invhist", column: "invhistexpcat_invhist_id", primary_key: "invhist_id", name: "invhistexpcat_invhistexpcat_invhist_id_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "ipsass", "ipshead", column: "ipsass_ipshead_id", primary_key: "ipshead_id", name: "ipsass_ipsass_ipshead_id_fkey"
  add_foreign_key "ipsfreight", "freightclass", column: "ipsfreight_freightclass_id", primary_key: "freightclass_id", name: "ipsfreight_ipsfreight_freightclass_id_fkey"
  add_foreign_key "ipsfreight", "ipshead", column: "ipsfreight_ipshead_id", primary_key: "ipshead_id", name: "ipsfreight_ipsfreight_ipshead_id_fkey"
  add_foreign_key "ipsfreight", "shipzone", column: "ipsfreight_shipzone_id", primary_key: "shipzone_id", name: "ipsfreight_ipsfreight_shipzone_id_fkey"
  add_foreign_key "ipsfreight", "whsinfo", column: "ipsfreight_warehous_id", primary_key: "warehous_id", name: "ipsfreight_ipsfreight_warehous_id_fkey"
  add_foreign_key "ipshead", "curr_symbol", column: "ipshead_curr_id", primary_key: "curr_id", name: "ipshead_to_curr_symbol"
  add_foreign_key "ipsitemchar", "\"char\"", column: "ipsitemchar_char_id", primary_key: "char_id", name: "ipsitemchar_ipsitemchar_char_id_fkey"
  add_foreign_key "ipsitemchar", "ipsiteminfo", column: "ipsitemchar_ipsitem_id", primary_key: "ipsitem_id", name: "ipsitemchar_ipsitemchar_ipsitem_id_fkey", on_delete: :cascade
  add_foreign_key "ipsiteminfo", "ipshead", column: "ipsitem_ipshead_id", primary_key: "ipshead_id", name: "ipsitem_ipshead_id_fk", on_delete: :cascade
  add_foreign_key "ipsiteminfo", "item", column: "ipsitem_item_id", primary_key: "item_id", name: "ipsitem_item_id_fk"
  add_foreign_key "ipsiteminfo", "uom", column: "ipsitem_price_uom_id", primary_key: "uom_id", name: "ipsitem_ipsitem_price_uom_id_fkey"
  add_foreign_key "ipsiteminfo", "uom", column: "ipsitem_qty_uom_id", primary_key: "uom_id", name: "ipsitem_ipsitem_qty_uom_id_fkey"
  add_foreign_key "ipsiteminfo", "whsinfo", column: "ipsitem_warehous_id", primary_key: "warehous_id", name: "ipsitem_ipsitem_warehous_id_fkey"
  add_foreign_key "item", "classcode", column: "item_classcode_id", primary_key: "classcode_id", name: "item_item_classcode_id_fkey"
  add_foreign_key "item", "freightclass", column: "item_freightclass_id", primary_key: "freightclass_id", name: "item_item_freightclass_id_fkey"
  add_foreign_key "item", "uom", column: "item_inv_uom_id", primary_key: "uom_id", name: "item_item_inv_uom_id_fkey"
  add_foreign_key "item", "uom", column: "item_price_uom_id", primary_key: "uom_id", name: "item_item_price_uom_id_fkey"
  add_foreign_key "itemalias", "crmacct", column: "itemalias_crmacct_id", primary_key: "crmacct_id", name: "itemalias_itemalias_crmacct_id_fkey"
  add_foreign_key "itemalias", "item", column: "itemalias_item_id", primary_key: "item_id", name: "itemalias_itemalias_item_id_fkey"
  add_foreign_key "itemcost", "costelem", column: "itemcost_costelem_id", primary_key: "costelem_id", name: "itemcost_itemcost_costelem_id_fkey"
  add_foreign_key "itemcost", "curr_symbol", column: "itemcost_curr_id", primary_key: "curr_id", name: "itemcost_itemcost_curr_id_fkey"
  add_foreign_key "itemcost", "curr_symbol", column: "itemcost_curr_id", primary_key: "curr_id", name: "itemcost_to_curr_symbol"
  add_foreign_key "itemcost", "item", column: "itemcost_item_id", primary_key: "item_id", name: "itemcost_itemcost_item_id_fkey"
  add_foreign_key "itemloc", "ls", column: "itemloc_ls_id", primary_key: "ls_id", name: "itemloc_itemloc_ls_id_fkey"
  add_foreign_key "itemlocdist", "ls", column: "itemlocdist_ls_id", primary_key: "ls_id", name: "itemlocdist_itemlocdist_ls_id_fkey"
  add_foreign_key "itemsite", "costcat", column: "itemsite_costcat_id", primary_key: "costcat_id", name: "itemsite_itemsite_costcat_id_fkey"
  add_foreign_key "itemsite", "item", column: "itemsite_item_id", primary_key: "item_id", name: "itemsite_itemsite_item_id_fkey"
  add_foreign_key "itemsite", "plancode", column: "itemsite_plancode_id", primary_key: "plancode_id", name: "itemsite_itemsite_plancode_id_fkey"
  add_foreign_key "itemsite", "whsinfo", column: "itemsite_warehous_id", primary_key: "warehous_id", name: "itemsite_itemsite_warehous_id_fkey"
  add_foreign_key "itemsrc", "contrct", column: "itemsrc_contrct_id", primary_key: "contrct_id", name: "itemsrc_itemsrc_contrct_id_fkey"
  add_foreign_key "itemsrc", "item", column: "itemsrc_item_id", primary_key: "item_id", name: "itemsrc_itemsrc_item_id_fkey", on_delete: :cascade
  add_foreign_key "itemsrc", "vendinfo", column: "itemsrc_vend_id", primary_key: "vend_id", name: "itemsrc_itemsrc_vend_id_fkey", on_delete: :cascade
  add_foreign_key "itemsrcp", "curr_symbol", column: "itemsrcp_curr_id", primary_key: "curr_id", name: "itemsrcp_to_curr_symbol"
  add_foreign_key "itemsrcp", "itemsrc", column: "itemsrcp_itemsrc_id", primary_key: "itemsrc_id", name: "itemsrcp_itemsrcp_itemsrc_id_fkey", on_delete: :cascade
  add_foreign_key "itemsub", "item", column: "itemsub_parent_item_id", primary_key: "item_id", name: "itemsub_itemsub_parent_item_id_fkey"
  add_foreign_key "itemsub", "item", column: "itemsub_sub_item_id", primary_key: "item_id", name: "itemsub_itemsub_sub_item_id_fkey"
  add_foreign_key "itemtax", "item", column: "itemtax_item_id", primary_key: "item_id", name: "itemtax_itemtax_item_id_fkey"
  add_foreign_key "itemtax", "taxtype", column: "itemtax_taxtype_id", primary_key: "taxtype_id", name: "itemtax_itemtax_taxtype_id_fkey"
  add_foreign_key "itemtax", "taxzone", column: "itemtax_taxzone_id", primary_key: "taxzone_id", name: "itemtax_itemtax_taxzone_id_fkey"
  add_foreign_key "itemtrans", "item", column: "itemtrans_source_item_id", primary_key: "item_id", name: "itemtrans_itemtrans_source_item_id_fkey"
  add_foreign_key "itemtrans", "item", column: "itemtrans_target_item_id", primary_key: "item_id", name: "itemtrans_itemtrans_target_item_id_fkey"
  add_foreign_key "itemuom", "itemuomconv", column: "itemuom_itemuomconv_id", primary_key: "itemuomconv_id", name: "itemuom_itemuom_itemuomconv_id_fkey"
  add_foreign_key "itemuom", "uomtype", column: "itemuom_uomtype_id", primary_key: "uomtype_id", name: "itemuom_itemuom_uomtype_id_fkey"
  add_foreign_key "itemuomconv", "item", column: "itemuomconv_item_id", primary_key: "item_id", name: "itemuomconv_itemuomconv_item_id_fkey"
  add_foreign_key "itemuomconv", "uom", column: "itemuomconv_from_uom_id", primary_key: "uom_id", name: "itemuomconv_itemuomconv_from_uom_id_fkey"
  add_foreign_key "itemuomconv", "uom", column: "itemuomconv_to_uom_id", primary_key: "uom_id", name: "itemuomconv_itemuomconv_to_uom_id_fkey"
  add_foreign_key "ls", "item", column: "ls_item_id", primary_key: "item_id", name: "ls_ls_item_id_fkey"
  add_foreign_key "lsdetail", "ls", column: "lsdetail_ls_id", primary_key: "ls_id", name: "lsdetail_lsdetail_ls_id_fkey"
  add_foreign_key "lsreg", "cntct", column: "lsreg_cntct_id", primary_key: "cntct_id", name: "lsreg_lsreg_cntct_id_fkey"
  add_foreign_key "lsreg", "cohead", column: "lsreg_cohead_id", primary_key: "cohead_id", name: "lsreg_lsreg_cohead_id_fkey"
  add_foreign_key "lsreg", "crmacct", column: "lsreg_crmacct_id", primary_key: "crmacct_id", name: "lsreg_lsreg_crmacct_id_fkey"
  add_foreign_key "lsreg", "ls", column: "lsreg_ls_id", primary_key: "ls_id", name: "lsreg_lsreg_ls_id_fkey"
  add_foreign_key "lsreg", "regtype", column: "lsreg_regtype_id", primary_key: "regtype_id", name: "lsreg_lsreg_regtype_id_fkey"
  add_foreign_key "lsreg", "shiphead", column: "lsreg_shiphead_id", primary_key: "shiphead_id", name: "lsreg_lsreg_shiphead_id_fkey"
  add_foreign_key "lswarr", "crmacct", column: "lswarr_crmacct_id", primary_key: "crmacct_id", name: "lswarr_lswarr_crmacct_id_fkey"
  add_foreign_key "lswarr", "regtype", column: "lswarr_regtype_id", primary_key: "regtype_id", name: "lswarr_lswarr_regtype_id_fkey"
  add_foreign_key "mrghist", "cntct", column: "mrghist_cntct_id", primary_key: "cntct_id", name: "mrghist_mrghist_cntct_id_fkey", on_delete: :cascade
  add_foreign_key "ophead", "cntct", column: "ophead_cntct_id", primary_key: "cntct_id", name: "ophead_ophead_cntct_id_fkey"
  add_foreign_key "ophead", "crmacct", column: "ophead_crmacct_id", primary_key: "crmacct_id", name: "ophead_ophead_crmacct_id_fkey"
  add_foreign_key "ophead", "incdtpriority", column: "ophead_priority_id", primary_key: "incdtpriority_id", name: "ophead_ophead_priority_id_fkey"
  add_foreign_key "ophead", "opsource", column: "ophead_opsource_id", primary_key: "opsource_id", name: "ophead_ophead_opsource_id_fkey"
  add_foreign_key "ophead", "opstage", column: "ophead_opstage_id", primary_key: "opstage_id", name: "ophead_ophead_opstage_id_fkey"
  add_foreign_key "ophead", "optype", column: "ophead_optype_id", primary_key: "optype_id", name: "ophead_ophead_optype_id_fkey"
  add_foreign_key "pack", "shiphead", column: "pack_shiphead_id", primary_key: "shiphead_id", name: "pack_pack_shiphead_id_fkey"
  add_foreign_key "payco", "ccpay", column: "payco_ccpay_id", primary_key: "ccpay_id", name: "payco_payco_ccpay_id_fkey"
  add_foreign_key "payco", "cohead", column: "payco_cohead_id", primary_key: "cohead_id", name: "payco_payco_cohead_id_fkey"
  add_foreign_key "pkgdep", "pkghead", column: "pkgdep_parent_pkghead_id", primary_key: "pkghead_id", name: "pkgdep_pkgdep_parent_pkghead_id_fkey"
  add_foreign_key "pkgdep", "pkghead", column: "pkgdep_pkghead_id", primary_key: "pkghead_id", name: "pkgdep_pkgdep_pkghead_id_fkey"
  add_foreign_key "pkgitem", "pkghead", column: "pkgitem_pkghead_id", primary_key: "pkghead_id", name: "pkgitem_pkgitem_pkghead_id_fkey", on_delete: :cascade
  add_foreign_key "pohead", "addr", column: "pohead_shiptoaddress_id", primary_key: "addr_id", name: "pohead_pohead_shiptoddress_id_fkey"
  add_foreign_key "pohead", "cntct", column: "pohead_shipto_cntct_id", primary_key: "cntct_id", name: "pohead_pohead_shipto_cntct_id_fkey"
  add_foreign_key "pohead", "cntct", column: "pohead_vend_cntct_id", primary_key: "cntct_id", name: "pohead_pohead_vend_cntct_id_fkey"
  add_foreign_key "pohead", "cohead", column: "pohead_cohead_id", primary_key: "cohead_id", name: "pohead_pohead_cohead_id_fkey", on_delete: :nullify
  add_foreign_key "pohead", "curr_symbol", column: "pohead_curr_id", primary_key: "curr_id", name: "pohead_to_curr_symbol"
  add_foreign_key "pohead", "taxtype", column: "pohead_taxtype_id", primary_key: "taxtype_id", name: "pohead_pohead_taxtype_id_fkey"
  add_foreign_key "pohead", "taxzone", column: "pohead_taxzone_id", primary_key: "taxzone_id", name: "pohead_pohead_taxzone_id_fkey"
  add_foreign_key "pohead", "terms", column: "pohead_terms_id", primary_key: "terms_id", name: "pohead_pohead_terms_id_fkey"
  add_foreign_key "pohead", "vendaddrinfo", column: "pohead_vendaddr_id", primary_key: "vendaddr_id", name: "pohead_pohead_vendaddr_id_fkey"
  add_foreign_key "pohead", "vendinfo", column: "pohead_vend_id", primary_key: "vend_id", name: "pohead_pohead_vend_id_fkey"
  add_foreign_key "pohead", "whsinfo", column: "pohead_warehous_id", primary_key: "warehous_id", name: "pohead_pohead_warehous_id_fkey"
  add_foreign_key "poitem", "expcat", column: "poitem_expcat_id", primary_key: "expcat_id", name: "poitem_poitem_expcat_id_fkey"
  add_foreign_key "poitem", "itemsite", column: "poitem_itemsite_id", primary_key: "itemsite_id", name: "poitem_poitem_itemsite_id_fkey"
  add_foreign_key "poitem", "itemsrc", column: "poitem_itemsrc_id", primary_key: "itemsrc_id", name: "poitem_poitem_itemsrc_id_fkey"
  add_foreign_key "poitem", "prj", column: "poitem_prj_id", primary_key: "prj_id", name: "poitem_poitem_prj_id_fkey"
  add_foreign_key "poitem", "taxtype", column: "poitem_taxtype_id", primary_key: "taxtype_id", name: "poitem_poitem_taxtype_id_fkey"
  add_foreign_key "poreject", "recv", column: "poreject_recv_id", primary_key: "recv_id", name: "poreject_poreject_recv_id_fkey"
  add_foreign_key "poreject", "vendinfo", column: "poreject_vend_id", primary_key: "vend_id", name: "poreject_poreject_vend_id_fkey"
  add_foreign_key "prj", "cntct", column: "prj_cntct_id", primary_key: "cntct_id", name: "prj_prj_cntct_id_fkey"
  add_foreign_key "prj", "crmacct", column: "prj_crmacct_id", primary_key: "crmacct_id", name: "prj_prj_crmacct_id_fkey"
  add_foreign_key "prj", "prj", column: "prj_recurring_prj_id", primary_key: "prj_id", name: "prj_prj_recurring_prj_id_fkey"
  add_foreign_key "prj", "prjtype", column: "prj_prjtype_id", primary_key: "prjtype_id", name: "prj_prj_prjtype_id_fkey"
  add_foreign_key "prjtask", "prj", column: "prjtask_prj_id", primary_key: "prj_id", name: "prjtask_prjtask_prj_id_fkey"
  add_foreign_key "prospect", "cntct", column: "prospect_cntct_id", primary_key: "cntct_id", name: "prospect_prospect_cntct_id_fkey"
  add_foreign_key "prospect", "salesrep", column: "prospect_salesrep_id", primary_key: "salesrep_id", name: "prospect_prospect_salesrep_id_fkey"
  add_foreign_key "prospect", "taxzone", column: "prospect_taxzone_id", primary_key: "taxzone_id", name: "prospect_prospect_taxzone_id_fkey"
  add_foreign_key "prospect", "whsinfo", column: "prospect_warehous_id", primary_key: "warehous_id", name: "prospect_prospect_warehous_id_fkey"
  add_foreign_key "qryitem", "qryhead", column: "qryitem_qryhead_id", primary_key: "qryhead_id", name: "qryitem_qryitem_qryhead_id_fkey"
  add_foreign_key "quhead", "accnt", column: "quhead_misc_accnt_id", primary_key: "accnt_id", name: "quhead_quhead_misc_accnt_id_fkey"
  add_foreign_key "quhead", "cntct", column: "quhead_billto_cntct_id", primary_key: "cntct_id", name: "quhead_quhead_billto_cntct_id_fkey"
  add_foreign_key "quhead", "cntct", column: "quhead_shipto_cntct_id", primary_key: "cntct_id", name: "quhead_quhead_shipto_cntct_id_fkey"
  add_foreign_key "quhead", "curr_symbol", column: "quhead_curr_id", primary_key: "curr_id", name: "quhead_to_curr_symbol"
  add_foreign_key "quhead", "ophead", column: "quhead_ophead_id", primary_key: "ophead_id", name: "quhead_quhead_ophead_id_fkey"
  add_foreign_key "quhead", "prj", column: "quhead_prj_id", primary_key: "prj_id", name: "quhead_quhead_prj_id_fkey"
  add_foreign_key "quhead", "salesrep", column: "quhead_salesrep_id", primary_key: "salesrep_id", name: "quhead_quhead_salesrep_id_fkey"
  add_foreign_key "quhead", "saletype", column: "quhead_saletype_id", primary_key: "saletype_id", name: "quhead_quhead_saletype_id_fkey"
  add_foreign_key "quhead", "shiptoinfo", column: "quhead_shipto_id", primary_key: "shipto_id", name: "quhead_quhead_shipto_id_fkey"
  add_foreign_key "quhead", "shipzone", column: "quhead_shipzone_id", primary_key: "shipzone_id", name: "quhead_quhead_shipzone_id_fkey"
  add_foreign_key "quhead", "taxtype", column: "quhead_taxtype_id", primary_key: "taxtype_id", name: "quhead_quhead_taxtype_id_fkey"
  add_foreign_key "quhead", "taxzone", column: "quhead_taxzone_id", primary_key: "taxzone_id", name: "quhead_quhead_taxzone_id_fkey"
  add_foreign_key "quhead", "terms", column: "quhead_terms_id", primary_key: "terms_id", name: "quhead_quhead_terms_id_fkey"
  add_foreign_key "quhead", "whsinfo", column: "quhead_warehous_id", primary_key: "warehous_id", name: "quhead_quhead_warehous_id_fkey"
  add_foreign_key "quitem", "itemsrc", column: "quitem_itemsrc_id", primary_key: "itemsrc_id", name: "quitem_quitem_itemsrc_id_fkey"
  add_foreign_key "quitem", "taxtype", column: "quitem_taxtype_id", primary_key: "taxtype_id", name: "quitem_quitem_taxtype_id_fkey"
  add_foreign_key "quitem", "uom", column: "quitem_price_uom_id", primary_key: "uom_id", name: "quitem_quitem_price_uom_id_fkey"
  add_foreign_key "quitem", "uom", column: "quitem_qty_uom_id", primary_key: "uom_id", name: "quitem_quitem_qty_uom_id_fkey"
  add_foreign_key "rahead", "accnt", column: "rahead_misc_accnt_id", primary_key: "accnt_id", name: "rahead_rahead_misc_accnt_id_fkey"
  add_foreign_key "rahead", "cohead", column: "rahead_new_cohead_id", primary_key: "cohead_id", name: "rahead_rahead_new_cohead_id_fkey"
  add_foreign_key "rahead", "cohead", column: "rahead_orig_cohead_id", primary_key: "cohead_id", name: "rahead_rahead_orig_cohead_id_fkey"
  add_foreign_key "rahead", "curr_symbol", column: "rahead_curr_id", primary_key: "curr_id", name: "rahead_rahead_curr_id_fkey"
  add_foreign_key "rahead", "custinfo", column: "rahead_cust_id", primary_key: "cust_id", name: "rahead_rahead_cust_id_fkey"
  add_foreign_key "rahead", "incdt", column: "rahead_incdt_id", primary_key: "incdt_id", name: "rahead_rahead_incdt_id_fkey"
  add_foreign_key "rahead", "prj", column: "rahead_prj_id", primary_key: "prj_id", name: "rahead_rahead_prj_id_fkey"
  add_foreign_key "rahead", "rsncode", column: "rahead_rsncode_id", primary_key: "rsncode_id", name: "rahead_rahead_rsncode_id_fkey"
  add_foreign_key "rahead", "salesrep", column: "rahead_salesrep_id", primary_key: "salesrep_id", name: "rahead_rahead_salesrep_id_fkey"
  add_foreign_key "rahead", "saletype", column: "rahead_saletype_id", primary_key: "saletype_id", name: "rahead_rahead_saletype_id_fkey"
  add_foreign_key "rahead", "shiptoinfo", column: "rahead_shipto_id", primary_key: "shipto_id", name: "rahead_rahead_shipto_id_fkey"
  add_foreign_key "rahead", "shipzone", column: "rahead_shipzone_id", primary_key: "shipzone_id", name: "rahead_rahead_shipzone_id_fkey"
  add_foreign_key "rahead", "taxtype", column: "rahead_taxtype_id", primary_key: "taxtype_id", name: "rahead_rahead_taxtype_id_fkey"
  add_foreign_key "rahead", "taxzone", column: "rahead_taxzone_id", primary_key: "taxzone_id", name: "rahead_rahead_taxzone_id_fkey"
  add_foreign_key "rahist", "curr_symbol", column: "rahist_curr_id", primary_key: "curr_id", name: "rahist_rahist_curr_id_fkey"
  add_foreign_key "rahist", "uom", column: "rahist_uom_id", primary_key: "uom_id", name: "rahist_rahist_uom_id_fkey"
  add_foreign_key "raitem", "accnt", column: "raitem_cos_accnt_id", primary_key: "accnt_id", name: "raitem_raitem_cos_accnt_id_fkey"
  add_foreign_key "raitem", "coitem", column: "raitem_new_coitem_id", primary_key: "coitem_id", name: "raitem_raitem_new_coitem_id_fkey"
  add_foreign_key "raitem", "coitem", column: "raitem_orig_coitem_id", primary_key: "coitem_id", name: "raitem_raitem_orig_coitem_id_fkey"
  add_foreign_key "raitem", "itemsite", column: "raitem_coitem_itemsite_id", primary_key: "itemsite_id", name: "raitem_raitem_coitem_itemsite_id_fkey"
  add_foreign_key "raitem", "itemsite", column: "raitem_itemsite_id", primary_key: "itemsite_id", name: "raitem_raitem_itemsite_id_fkey"
  add_foreign_key "raitem", "rahead", column: "raitem_rahead_id", primary_key: "rahead_id", name: "raitem_raitem_rahead_id_fkey", on_delete: :cascade
  add_foreign_key "raitem", "rsncode", column: "raitem_rsncode_id", primary_key: "rsncode_id", name: "raitem_raitem_rsncode_id_fkey"
  add_foreign_key "raitem", "uom", column: "raitem_price_uom_id", primary_key: "uom_id", name: "raitem_raitem_price_uom_id_fkey"
  add_foreign_key "raitem", "uom", column: "raitem_qty_uom_id", primary_key: "uom_id", name: "raitem_raitem_qty_uom_id_fkey"
  add_foreign_key "raitemls", "ls", column: "raitemls_ls_id", primary_key: "ls_id", name: "raitemls_raitemls_ls_id_fkey"
  add_foreign_key "raitemls", "raitem", column: "raitemls_raitem_id", primary_key: "raitem_id", name: "raitemls_raitemls_raitem_id_fkey", on_delete: :cascade
  add_foreign_key "recv", "curr_symbol", column: "recv_freight_curr_id", primary_key: "curr_id", name: "recv_recv_freight_curr_id_fkey"
  add_foreign_key "recv", "curr_symbol", column: "recv_purchcost_curr_id", primary_key: "curr_id", name: "recv_recv_purchcost_curr_id_fkey"
  add_foreign_key "recv", "curr_symbol", column: "recv_recvcost_curr_id", primary_key: "curr_id", name: "recv_recv_recvcost_curr_id_fkey"
  add_foreign_key "recv", "itemsite", column: "recv_itemsite_id", primary_key: "itemsite_id", name: "recv_recv_itemsite_id_fkey"
  add_foreign_key "recv", "recv", column: "recv_splitfrom_id", primary_key: "recv_id", name: "recv_recv_splitfrom_id_fkey"
  add_foreign_key "recv", "vendinfo", column: "recv_vend_id", primary_key: "vend_id", name: "recv_recv_vend_id_fkey"
  add_foreign_key "recv", "vohead", column: "recv_vohead_id", primary_key: "vohead_id", name: "recv_recv_vohead_id_fkey"
  add_foreign_key "recv", "voitem", column: "recv_voitem_id", primary_key: "voitem_id", name: "recv_recv_voitem_id_fkey"
  add_foreign_key "salesrep", "emp", column: "salesrep_emp_id", primary_key: "emp_id", name: "salesrep_salesrep_emp_id_fkey"
  add_foreign_key "shipdata", "curr_symbol", column: "shipdata_base_freight_curr_id", primary_key: "curr_id", name: "shipdata_shipdata_base_freight_curr_id_fkey"
  add_foreign_key "shipdata", "curr_symbol", column: "shipdata_total_freight_curr_id", primary_key: "curr_id", name: "shipdata_shipdata_total_freight_curr_id_fkey"
  add_foreign_key "shipdata", "shiphead", column: "shipdata_shiphead_number", primary_key: "shiphead_number", name: "shipdata_shipdata_shiphead_number_fkey"
  add_foreign_key "shipdatasum", "curr_symbol", column: "shipdatasum_base_freight_curr_id", primary_key: "curr_id", name: "shipdatasum_shipdatasum_base_freight_curr_id_fkey"
  add_foreign_key "shipdatasum", "curr_symbol", column: "shipdatasum_total_freight_curr_id", primary_key: "curr_id", name: "shipdatasum_shipdatasum_total_freight_curr_id_fkey"
  add_foreign_key "shipdatasum", "shiphead", column: "shipdatasum_shiphead_number", primary_key: "shiphead_number", name: "shipdatasum_shipdatasum_shiphead_number_fkey"
  add_foreign_key "shiphead", "curr_symbol", column: "shiphead_freight_curr_id", primary_key: "curr_id", name: "shiphead_shiphead_freight_curr_id_fkey"
  add_foreign_key "shiphead", "shipchrg", column: "shiphead_shipchrg_id", primary_key: "shipchrg_id", name: "shiphead_shiphead_shipchrg_id_fkey"
  add_foreign_key "shiphead", "shipform", column: "shiphead_shipform_id", primary_key: "shipform_id", name: "shiphead_shiphead_shipform_id_fkey"
  add_foreign_key "shipitem", "invcitem", column: "shipitem_invcitem_id", primary_key: "invcitem_id", name: "shipitem_shipitem_invcitem_id_fkey"
  add_foreign_key "shipitem", "invhist", column: "shipitem_invhist_id", primary_key: "invhist_id", name: "shipitem_shipitem_invhist_id_fkey"
  add_foreign_key "shipitem", "shiphead", column: "shipitem_shiphead_id", primary_key: "shiphead_id", name: "shipitem_shipitem_shiphead_id_fkey"
  add_foreign_key "shipitemlocrsrv", "itemsite", column: "shipitemlocrsrv_itemsite_id", primary_key: "itemsite_id", name: "shipitemlocrsrv_shipitemlocrsrv_itemsite_id_fkey"
  add_foreign_key "shipitemlocrsrv", "ls", column: "shipitemlocrsrv_ls_id", primary_key: "ls_id", name: "shipitemlocrsrv_shipitemlocrsrv_ls_id_fkey"
  add_foreign_key "shipitemlocrsrv", "shipitem", column: "shipitemlocrsrv_shipitem_id", primary_key: "shipitem_id", name: "shipitemlocrsrv_shipitemlocrsrv_shipitem_id_fkey", on_delete: :cascade
  add_foreign_key "shipitemrsrv", "shipitem", column: "shipitemrsrv_shipitem_id", primary_key: "shipitem_id", name: "shipitemrsrv_shipitemrsrv_shipitem_id_fkey", on_delete: :cascade
  add_foreign_key "shiptoinfo", "addr", column: "shipto_addr_id", primary_key: "addr_id", name: "shiptoinfo_shipto_addr_id_fkey"
  add_foreign_key "shiptoinfo", "cntct", column: "shipto_cntct_id", primary_key: "cntct_id", name: "shiptoinfo_shipto_cntct_id_fkey"
  add_foreign_key "shiptoinfo", "custinfo", column: "shipto_cust_id", primary_key: "cust_id", name: "shiptoinfo_shipto_cust_id_fkey"
  add_foreign_key "shiptoinfo", "salesrep", column: "shipto_salesrep_id", primary_key: "salesrep_id", name: "shiptoinfo_shipto_salesrep_fkey", on_update: :restrict, on_delete: :restrict
  add_foreign_key "shiptoinfo", "salesrep", column: "shipto_salesrep_id", primary_key: "salesrep_id", name: "shiptoinfo_shipto_salesrep_id_fkey"
  add_foreign_key "shiptoinfo", "shipform", column: "shipto_shipform_id", primary_key: "shipform_id", name: "shiptoinfo_shipto_shipform_fkey", on_update: :restrict, on_delete: :restrict
  add_foreign_key "shiptoinfo", "shipform", column: "shipto_shipform_id", primary_key: "shipform_id", name: "shiptoinfo_shipto_shipform_id_fkey"
  add_foreign_key "shiptoinfo", "shipzone", column: "shipto_shipzone_id", primary_key: "shipzone_id", name: "shiptoinfo_shipto_shipzone_id_fkey"
  add_foreign_key "shiptoinfo", "taxzone", column: "shipto_taxzone_id", primary_key: "taxzone_id", name: "shiptoinfo_shipto_taxzone_id_fkey"
  add_foreign_key "state", "country", column: "state_country_id", primary_key: "country_id", name: "state_state_country_id_fkey"
  add_foreign_key "tax", "accnt", column: "tax_sales_accnt_id", primary_key: "accnt_id", name: "tax_tax_sales_accnt_id_fkey"
  add_foreign_key "tax", "tax", column: "tax_basis_tax_id", primary_key: "tax_id", name: "tax_tax_basis_tax_id_fkey", on_delete: :cascade
  add_foreign_key "tax", "taxauth", column: "tax_taxauth_id", primary_key: "taxauth_id", name: "tax_tax_taxauth_id_fkey"
  add_foreign_key "tax", "taxclass", column: "tax_taxclass_id", primary_key: "taxclass_id", name: "tax_tax_taxclass_id_fkey"
  add_foreign_key "taxass", "tax", column: "taxass_tax_id", primary_key: "tax_id", name: "taxass_taxass_tax_id_fkey"
  add_foreign_key "taxass", "taxtype", column: "taxass_taxtype_id", primary_key: "taxtype_id", name: "taxass_taxass_taxtype_id_fkey"
  add_foreign_key "taxass", "taxzone", column: "taxass_taxzone_id", primary_key: "taxzone_id", name: "taxass_taxass_taxzone_id_fkey"
  add_foreign_key "taxauth", "accnt", column: "taxauth_accnt_id", primary_key: "accnt_id", name: "taxauth_taxauth_accnt_id_fkey"
  add_foreign_key "taxauth", "addr", column: "taxauth_addr_id", primary_key: "addr_id", name: "taxauth_taxauth_addr_id_fkey"
  add_foreign_key "taxauth", "curr_symbol", column: "taxauth_curr_id", primary_key: "curr_id", name: "taxauth_taxauth_curr_id_fkey"
  add_foreign_key "taxhist", "curr_symbol", column: "taxhist_curr_id", primary_key: "curr_id", name: "taxhist_taxhist_curr_id_fkey"
  add_foreign_key "taxhist", "tax", column: "taxhist_tax_id", primary_key: "tax_id", name: "taxhist_taxhist_tax_id_fkey"
  add_foreign_key "taxhist", "taxtype", column: "taxhist_taxtype_id", primary_key: "taxtype_id", name: "taxhist_taxhist_taxtype_id_fkey"
  add_foreign_key "taxrate", "curr_symbol", column: "taxrate_curr_id", primary_key: "curr_id", name: "taxrate_taxrate_curr_id_fkey"
  add_foreign_key "taxrate", "tax", column: "taxrate_tax_id", primary_key: "tax_id", name: "taxrate_taxrate_tax_id_fkey"
  add_foreign_key "taxreg", "taxauth", column: "taxreg_taxauth_id", primary_key: "taxauth_id", name: "taxreg_taxreg_taxauth_id_fkey"
  add_foreign_key "taxreg", "taxzone", column: "taxreg_taxzone_id", primary_key: "taxzone_id", name: "taxreg_taxreg_taxzone_id_fkey"
  add_foreign_key "todoitem", "cntct", column: "todoitem_cntct_id", primary_key: "cntct_id", name: "todoitem_todoitem_cntct_id_fkey"
  add_foreign_key "todoitem", "crmacct", column: "todoitem_crmacct_id", primary_key: "crmacct_id", name: "todoitem_todoitem_crmacct_id_fkey"
  add_foreign_key "todoitem", "incdt", column: "todoitem_incdt_id", primary_key: "incdt_id", name: "todoitem_todoitem_incdt_id_fkey"
  add_foreign_key "todoitem", "ophead", column: "todoitem_ophead_id", primary_key: "ophead_id", name: "todoitem_todoitem_ophead_id_fkey", on_update: :restrict, on_delete: :restrict
  add_foreign_key "todoitem", "todoitem", column: "todoitem_recurring_todoitem_id", primary_key: "todoitem_id", name: "todoitem_todoitem_recurring_todoitem_id_fkey"
  add_foreign_key "tohead", "cntct", column: "tohead_destcntct_id", primary_key: "cntct_id", name: "tohead_tohead_destcntct_id_fkey"
  add_foreign_key "tohead", "cntct", column: "tohead_srccntct_id", primary_key: "cntct_id", name: "tohead_tohead_srccntct_id_fkey"
  add_foreign_key "tohead", "curr_symbol", column: "tohead_freight_curr_id", primary_key: "curr_id", name: "tohead_tohead_freight_curr_id_fkey"
  add_foreign_key "tohead", "prj", column: "tohead_prj_id", primary_key: "prj_id", name: "tohead_tohead_prj_id_fkey"
  add_foreign_key "tohead", "shipchrg", column: "tohead_shipchrg_id", primary_key: "shipchrg_id", name: "tohead_tohead_shipchrg_id_fkey"
  add_foreign_key "tohead", "shipform", column: "tohead_shipform_id", primary_key: "shipform_id", name: "tohead_tohead_shipform_id_fkey"
  add_foreign_key "tohead", "taxzone", column: "tohead_taxzone_id", primary_key: "taxzone_id", name: "tohead_tohead_taxzone_id_fkey"
  add_foreign_key "tohead", "whsinfo", column: "tohead_dest_warehous_id", primary_key: "warehous_id", name: "tohead_tohead_dest_warehous_id_fkey"
  add_foreign_key "tohead", "whsinfo", column: "tohead_src_warehous_id", primary_key: "warehous_id", name: "tohead_tohead_src_warehous_id_fkey"
  add_foreign_key "tohead", "whsinfo", column: "tohead_trns_warehous_id", primary_key: "warehous_id", name: "tohead_tohead_trns_warehous_id_fkey"
  add_foreign_key "toheadtax", "tax", column: "taxhist_basis_tax_id", primary_key: "tax_id", name: "toheadtax_taxhist_basis_tax_id_fkey"
  add_foreign_key "toheadtax", "tax", column: "taxhist_tax_id", primary_key: "tax_id", name: "toheadtax_taxhist_tax_id_fkey"
  add_foreign_key "toheadtax", "taxtype", column: "taxhist_taxtype_id", primary_key: "taxtype_id", name: "toheadtax_taxhist_taxtype_id_fkey"
  add_foreign_key "toheadtax", "tohead", column: "taxhist_parent_id", primary_key: "tohead_id", name: "toheadtax_taxhist_parent_id_fkey", on_delete: :cascade
  add_foreign_key "toitem", "curr_symbol", column: "toitem_freight_curr_id", primary_key: "curr_id", name: "toitem_toitem_freight_curr_id_fkey"
  add_foreign_key "toitem", "item", column: "toitem_item_id", primary_key: "item_id", name: "toitem_toitem_item_id_fkey"
  add_foreign_key "toitem", "prj", column: "toitem_prj_id", primary_key: "prj_id", name: "toitem_toitem_prj_id_fkey"
  add_foreign_key "toitem", "tohead", column: "toitem_tohead_id", primary_key: "tohead_id", name: "toitem_toitem_tohead_id_fkey"
  add_foreign_key "toitemtax", "tax", column: "taxhist_basis_tax_id", primary_key: "tax_id", name: "toitemtax_taxhist_basis_tax_id_fkey"
  add_foreign_key "toitemtax", "tax", column: "taxhist_tax_id", primary_key: "tax_id", name: "toitemtax_taxhist_tax_id_fkey"
  add_foreign_key "toitemtax", "taxtype", column: "taxhist_taxtype_id", primary_key: "taxtype_id", name: "toitemtax_taxhist_taxtype_id_fkey"
  add_foreign_key "toitemtax", "toitem", column: "taxhist_parent_id", primary_key: "toitem_id", name: "toitemtax_taxhist_parent_id_fkey", on_delete: :cascade
  add_foreign_key "trgthist", "cntct", column: "trgthist_trgt_cntct_id", primary_key: "cntct_id", name: "trgthist_trgthist_trgt_cntct_id_fkey", on_delete: :cascade
  add_foreign_key "trgthist", "cntctmrgd", column: "trgthist_src_cntct_id", primary_key: "cntctmrgd_cntct_id", name: "trgthist_trgthist_src_cntct_id_fkey", on_delete: :cascade
  add_foreign_key "trialbalsync", "curr_symbol", column: "trialbalsync_curr_id", primary_key: "curr_id", name: "trialbalsync_trialbalsync_curr_id_fkey"
  add_foreign_key "uomconv", "uom", column: "uomconv_from_uom_id", primary_key: "uom_id", name: "uomconv_uomconv_from_uom_id_fkey"
  add_foreign_key "uomconv", "uom", column: "uomconv_to_uom_id", primary_key: "uom_id", name: "uomconv_uomconv_to_uom_id_fkey"
  add_foreign_key "usrgrp", "grp", column: "usrgrp_grp_id", primary_key: "grp_id", name: "usrgrp_usrgrp_grp_id_fkey"
  add_foreign_key "usrsite", "whsinfo", column: "usrsite_warehous_id", primary_key: "warehous_id", name: "usrsite_usrsite_warehous_id_fkey", on_delete: :cascade
  add_foreign_key "vendaddrinfo", "addr", column: "vendaddr_addr_id", primary_key: "addr_id", name: "vendaddrinfo_vendaddr_addr_id_fkey"
  add_foreign_key "vendaddrinfo", "cntct", column: "vendaddr_cntct_id", primary_key: "cntct_id", name: "vendaddrinfo_vendaddr_cntct_id_fkey"
  add_foreign_key "vendaddrinfo", "taxzone", column: "vendaddr_taxzone_id", primary_key: "taxzone_id", name: "vendaddrinfo_vendaddr_taxzone_id_fkey"
  add_foreign_key "vendinfo", "addr", column: "vend_addr_id", primary_key: "addr_id", name: "vendinfo_vend_addr_id_fkey"
  add_foreign_key "vendinfo", "cntct", column: "vend_cntct1_id", primary_key: "cntct_id", name: "vend_vend_cntct1_id_fkey"
  add_foreign_key "vendinfo", "cntct", column: "vend_cntct2_id", primary_key: "cntct_id", name: "vend_vend_cntct2_id_fkey"
  add_foreign_key "vendinfo", "curr_symbol", column: "vend_curr_id", primary_key: "curr_id", name: "vend_to_curr_symbol"
  add_foreign_key "vendinfo", "taxzone", column: "vend_taxzone_id", primary_key: "taxzone_id", name: "vendinfo_vend_taxzone_id_fkey"
  add_foreign_key "vendinfo", "vendtype", column: "vend_vendtype_id", primary_key: "vendtype_id", name: "vendinfo_vend_vendtype_id_fkey"
  add_foreign_key "vohead", "curr_symbol", column: "vohead_curr_id", primary_key: "curr_id", name: "vohead_to_curr_symbol"
  add_foreign_key "vohead", "taxtype", column: "vohead_adjtaxtype_id", primary_key: "taxtype_id", name: "vohead_vohead_adjtaxtype_id_fkey"
  add_foreign_key "vohead", "taxtype", column: "vohead_freighttaxtype_id", primary_key: "taxtype_id", name: "vohead_vohead_freighttaxtype_id_fkey"
  add_foreign_key "vohead", "taxtype", column: "vohead_taxtype_id", primary_key: "taxtype_id", name: "vohead_vohead_taxtype_id_fkey"
  add_foreign_key "vohead", "taxzone", column: "vohead_taxzone_id", primary_key: "taxzone_id", name: "vohead_vohead_taxzone_id_fkey"
  add_foreign_key "vohead", "vendinfo", column: "vohead_vend_id", primary_key: "vend_id", name: "vohead_vohead_vend_id_fkey"
  add_foreign_key "voheadtax", "tax", column: "taxhist_basis_tax_id", primary_key: "tax_id", name: "voheadtax_taxhist_basis_tax_id_fkey"
  add_foreign_key "voheadtax", "tax", column: "taxhist_tax_id", primary_key: "tax_id", name: "voheadtax_taxhist_tax_id_fkey"
  add_foreign_key "voheadtax", "taxtype", column: "taxhist_taxtype_id", primary_key: "taxtype_id", name: "voheadtax_taxhist_taxtype_id_fkey"
  add_foreign_key "voheadtax", "vohead", column: "taxhist_parent_id", primary_key: "vohead_id", name: "voheadtax_taxhist_parent_id_fkey", on_delete: :cascade
  add_foreign_key "voitem", "taxtype", column: "voitem_taxtype_id", primary_key: "taxtype_id", name: "voitem_voitem_taxtype_id_fkey"
  add_foreign_key "voitemtax", "tax", column: "taxhist_basis_tax_id", primary_key: "tax_id", name: "voitemtax_taxhist_basis_tax_id_fkey"
  add_foreign_key "voitemtax", "tax", column: "taxhist_tax_id", primary_key: "tax_id", name: "voitemtax_taxhist_tax_id_fkey"
  add_foreign_key "voitemtax", "taxtype", column: "taxhist_taxtype_id", primary_key: "taxtype_id", name: "voitemtax_taxhist_taxtype_id_fkey"
  add_foreign_key "voitemtax", "voitem", column: "taxhist_parent_id", primary_key: "voitem_id", name: "voitemtax_taxhist_parent_id_fkey", on_delete: :cascade
  add_foreign_key "whsinfo", "accnt", column: "warehous_default_accnt_id", primary_key: "accnt_id", name: "whsinfo_warehous_accnt_id_fkey"
  add_foreign_key "whsinfo", "addr", column: "warehous_addr_id", primary_key: "addr_id", name: "whsinfo_warehous_addr_id_fkey"
  add_foreign_key "whsinfo", "cntct", column: "warehous_cntct_id", primary_key: "cntct_id", name: "whsinfo_warehous_cntct_id_fkey"
  add_foreign_key "whsinfo", "costcat", column: "warehous_costcat_id", primary_key: "costcat_id", name: "whsinfo_warehous_costcat_id_fkey"
  add_foreign_key "whsinfo", "shipform", column: "warehous_shipform_id", primary_key: "shipform_id", name: "whsinfo_warehous_shipform_id_fkey"
  add_foreign_key "whsinfo", "shipvia", column: "warehous_shipvia_id", primary_key: "shipvia_id", name: "whsinfo_warehous_shipvia_id_fkey"
  add_foreign_key "whsinfo", "sitetype", column: "warehous_sitetype_id", primary_key: "sitetype_id", name: "whsinfo_warehous_sitetype_id_fkey"
  add_foreign_key "whsinfo", "taxzone", column: "warehous_taxzone_id", primary_key: "taxzone_id", name: "whsinfo_warehous_taxzone_id_fkey"
  add_foreign_key "wo", "womatl", column: "wo_womatl_id", primary_key: "womatl_id", name: "wo_wo_womatl_id_fkey", on_delete: :nullify
  add_foreign_key "womatl", "uom", column: "womatl_uom_id", primary_key: "uom_id", name: "womatl_womatl_uom_id_fkey"
  add_foreign_key "womatlpost", "invhist", column: "womatlpost_invhist_id", primary_key: "invhist_id", name: "womatlpost_womatlpost_invhist_id_fkey"
  add_foreign_key "womatlpost", "womatl", column: "womatlpost_womatl_id", primary_key: "womatl_id", name: "womatlpost_womatlpost_womatl_id_fkey", on_delete: :cascade
end
