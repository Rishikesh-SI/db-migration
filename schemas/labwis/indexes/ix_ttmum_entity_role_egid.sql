-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: ix_ttmum_entity_role_egid
-- Type: INDEX

-- Name: ix_ttmum_entity_role_egid; Type: INDEX; Schema: labwis; Owner: -
--

CREATE INDEX ix_ttmum_entity_role_egid ON labwis.labwis_entity_role USING btree (entity_group_id);


--
