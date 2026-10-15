-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: idx_asset_list_det_array
-- Type: INDEX

-- Name: idx_asset_list_det_array; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX idx_asset_list_det_array ON yho.yho_asset_list_detail USING gin (ent_col public.gin__int_ops);


--
