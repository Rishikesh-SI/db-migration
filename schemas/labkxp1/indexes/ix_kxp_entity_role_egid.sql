-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: ix_kxp_entity_role_egid
-- Type: INDEX

-- Name: ix_kxp_entity_role_egid; Type: INDEX; Schema: labkxp1; Owner: -
--

CREATE INDEX ix_kxp_entity_role_egid ON labkxp1.labkxp_entity_role USING btree (entity_group_id);


--
