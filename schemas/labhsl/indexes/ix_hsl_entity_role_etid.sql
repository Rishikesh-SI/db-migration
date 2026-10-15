-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: ix_hsl_entity_role_etid
-- Type: INDEX

-- Name: ix_hsl_entity_role_etid; Type: INDEX; Schema: labhsl; Owner: -
--

CREATE INDEX ix_hsl_entity_role_etid ON labhsl.labhsl_entity_role USING btree (entity_type_id);


--
