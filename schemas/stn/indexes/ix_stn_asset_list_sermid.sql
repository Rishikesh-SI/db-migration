-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_asset_list_sermid
-- Type: INDEX

-- Name: ix_stn_asset_list_sermid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_asset_list_sermid ON stn.stn_asset_list USING btree (secondary_entity_role_map_id);


--
