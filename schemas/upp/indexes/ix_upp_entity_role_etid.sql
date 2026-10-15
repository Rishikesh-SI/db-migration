-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_entity_role_etid
-- Type: INDEX

-- Name: ix_upp_entity_role_etid; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_entity_role_etid ON upp.upp_entity_role USING btree (entity_type_id);


--
