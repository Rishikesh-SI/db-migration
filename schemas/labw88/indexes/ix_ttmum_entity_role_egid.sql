-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: ix_ttmum_entity_role_egid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_egid; Type: INDEX; Schema: labw88; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_egid ON labw88.labw88_entity_role USING btree (entity_group_id);


--
