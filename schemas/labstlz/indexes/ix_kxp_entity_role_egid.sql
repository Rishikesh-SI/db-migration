-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstlz
-- Object: ix_kxp_entity_role_egid
-- Type: INDEX

-- Name: ix_kxp_entity_role_egid; Type: INDEX; Schema: labstlz; Owner: -
--

CREATE INDEX ix_kxp_entity_role_egid ON labstlz.labstlz_entity_role USING btree (entity_group_id);


--
