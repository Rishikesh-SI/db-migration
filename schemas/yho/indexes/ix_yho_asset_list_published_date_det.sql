-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: ix_yho_asset_list_published_date_det
-- Type: INDEX

-- Name: ix_yho_asset_list_published_date_det; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX ix_yho_asset_list_published_date_det ON yho.yho_asset_list_detail USING btree (published_date DESC);


--
