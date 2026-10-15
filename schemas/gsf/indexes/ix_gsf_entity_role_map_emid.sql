-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_entity_role_map_emid
-- Type: INDEX

-- Name: ix_gsf_entity_role_map_emid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_entity_role_map_emid ON gsf.gsf_entity_role_map USING btree (entity_master_id);


--
