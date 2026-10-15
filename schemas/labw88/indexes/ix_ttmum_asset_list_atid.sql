-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_ttmum_asset_list_atid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_atid; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_atid ON labw88.labw88_asset_list USING btree (asset_type_id);


--
