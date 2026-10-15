-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_entity_role_egid
-- Type: INDEX

-- Name: ix_isl_entity_role_egid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_entity_role_egid ON isl.isl_entity_role USING btree (entity_group_id);


--
