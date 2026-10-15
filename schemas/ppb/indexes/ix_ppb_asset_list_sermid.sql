-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ppb
-- Object: ix_ppb_asset_list_sermid
-- Type: INDEX

-- Name: ix_ppb_asset_list_sermid; Type: INDEX; Schema: ppb; Owner: -
--

CREATE INDEX ix_ppb_asset_list_sermid ON ppb.ppb_asset_list USING btree (secondary_entity_role_map_id);


--
