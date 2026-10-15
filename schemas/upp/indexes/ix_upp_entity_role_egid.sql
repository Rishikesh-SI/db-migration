-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: ix_upp_entity_role_egid
-- Type: INDEX

-- Name: ix_upp_entity_role_egid; Type: INDEX; Schema: upp; Owner: -
--

CREATE INDEX ix_upp_entity_role_egid ON upp.upp_entity_role USING btree (entity_group_id);


--
