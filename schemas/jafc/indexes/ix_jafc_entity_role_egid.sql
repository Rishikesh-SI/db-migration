-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: ix_jafc_entity_role_egid
-- Type: INDEX

-- Name: ix_jafc_entity_role_egid; Type: INDEX; Schema: jafc; Owner: -
--

CREATE INDEX ix_jafc_entity_role_egid ON jafc.jafc_entity_role USING btree (entity_group_id);


--
