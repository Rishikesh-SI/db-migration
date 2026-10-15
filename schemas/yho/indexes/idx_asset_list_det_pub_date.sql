-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: idx_asset_list_det_pub_date
-- Type: INDEX

-- Name: idx_asset_list_det_pub_date; Type: INDEX; Schema: yho; Owner: -
--

CREATE INDEX idx_asset_list_det_pub_date ON yho.yho_asset_list_detail USING btree (published_date DESC);


--
