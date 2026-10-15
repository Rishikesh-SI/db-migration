-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_entity_role_egid
-- Type: INDEX

-- Name: ix_ttgl_entity_role_egid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_entity_role_egid ON ttgl.ttgl_entity_role USING btree (entity_group_id);


--
