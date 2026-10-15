-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: ix_isl_entity_role_etid
-- Type: INDEX

-- Name: ix_isl_entity_role_etid; Type: INDEX; Schema: isl; Owner: -
--

CREATE INDEX ix_isl_entity_role_etid ON isl.isl_entity_role USING btree (entity_type_id);


--
