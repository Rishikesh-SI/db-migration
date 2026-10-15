-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_entity_role_etid
-- Type: INDEX

-- Name: ix_hsl_entity_role_etid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_entity_role_etid ON hsl.hsl_entity_role USING btree (entity_type_id);


--
