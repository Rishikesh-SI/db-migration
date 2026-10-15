-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: ix_ttmum_asset_list_sermid
-- Type: INDEX

-- Name: ix_ttmum_asset_list_sermid; Type: INDEX; Schema: lb_wf; Owner: -
--

CREATE INDEX ix_ttmum_asset_list_sermid ON lb_wf.lb_wf_asset_list USING btree (secondary_entity_role_map_id);


--
