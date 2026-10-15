-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: ix_pkl_entity_role_etid
-- Type: INDEX

-- Name: ix_pkl_entity_role_etid; Type: INDEX; Schema: labpkl; Owner: -
--

CREATE INDEX ix_pkl_entity_role_etid ON labpkl.labpkl_entity_role USING btree (entity_type_id);


--
