-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: kxp
-- Object: ix_kxp_entity_role_map_emid
-- Type: INDEX

-- Name: ix_kxp_entity_role_map_emid; Type: INDEX; Schema: kxp; Owner: -
--

CREATE INDEX ix_kxp_entity_role_map_emid ON kxp.kxp_entity_role_map USING btree (entity_master_id);


--
