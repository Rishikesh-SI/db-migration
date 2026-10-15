-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: ix_pkl_entity_role_egid
-- Type: INDEX

-- Name: ix_pkl_entity_role_egid; Type: INDEX; Schema: labpkl_v1; Owner: -
--

CREATE INDEX ix_pkl_entity_role_egid ON labpkl_v1.labpkl_v1_entity_role USING btree (entity_group_id);


--
