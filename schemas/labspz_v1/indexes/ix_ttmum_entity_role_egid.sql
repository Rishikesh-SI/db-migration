-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labspz_v1
-- Object: ix_ttmum_entity_role_egid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_egid; Type: INDEX; Schema: labspz_v1; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_egid ON labspz_v1.labspz_v1_entity_role USING btree (entity_group_id);


--
