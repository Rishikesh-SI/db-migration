-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: ix_ttmum_asset_list_atid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_atid; Type: INDEX; Schema: labilt; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_atid ON labilt.labilt_asset_list USING btree (asset_type_id);


--
