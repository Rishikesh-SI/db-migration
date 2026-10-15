-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: ix_pkl_asset_list_sermid
-- Type: INDEX

-- Name: ix_pkl_asset_list_sermid; Type: INDEX; Schema: gfg; Owner: -
--

CREATE INDEX ix_pkl_asset_list_sermid ON gfg.gfg_asset_list USING btree (secondary_entity_role_map_id);


--
