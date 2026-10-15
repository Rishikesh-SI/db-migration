-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labctkr
-- Object: ix_ttmum_asset_list_atid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_atid; Type: INDEX; Schema: labctkr; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_atid ON labctkr.labctkr_asset_list USING btree (asset_type_id);


--
