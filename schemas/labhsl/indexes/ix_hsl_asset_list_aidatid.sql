-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_asset_list_aidatid
-- Type: INDEX

-- Name: ix_hsl_asset_list_aidatid; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_asset_list_aidatid ON labhsl.labhsl_asset_list USING btree (asset_id, asset_type_id);


--
