-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: ix_ttmum_asset_entity_map_aid
-- Type: INDEX

-- Name: ix_ttmum_asset_entity_map_aid; Type: INDEX; Schema: lb_wf; Owner: -
--

CREATE INDEX ix_ttmum_asset_entity_map_aid ON lb_wf.lb_wf_asset_entity_map USING btree (asset_id);


--
