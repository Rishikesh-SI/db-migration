-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: ix_dd_asset_list_atid
-- Type: INDEX

-- Name: ix_dd_asset_list_atid; Type: INDEX; Schema: dd; Owner: -
--

CREATE INDEX ix_dd_asset_list_atid ON dd.dd_asset_list USING btree (asset_type_id);


--
