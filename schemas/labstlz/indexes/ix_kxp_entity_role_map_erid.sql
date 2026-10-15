-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_entity_role_map_erid
-- Type: INDEX

-- Name: ix_kxp_entity_role_map_erid; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_entity_role_map_erid ON labstlz.labstlz_entity_role_map USING btree (entity_role_id);


--
