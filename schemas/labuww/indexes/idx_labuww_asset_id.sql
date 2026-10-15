-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: idx_labuww_asset_id
-- Type: INDEX

-- Name: idx_labuww_asset_id; Type: INDEX; Schema: labuww; Owner: -
--

CREATE INDEX idx_labuww_asset_id ON labuww.labuww_asset_process_log USING btree (asset_id);


--
