-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: ix_hsl_entity_role_egid
-- Type: INDEX

-- Name: ix_hsl_entity_role_egid; Type: INDEX; Schema: hsl; Owner: -
--

CREATE INDEX ix_hsl_entity_role_egid ON hsl.hsl_entity_role USING btree (entity_group_id);


--
