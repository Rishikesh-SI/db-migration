-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: ix_spz_entity_role_egid
-- Type: INDEX

-- Name: ix_spz_entity_role_egid; Type: INDEX; Schema: spz; Owner: -
--

CREATE INDEX ix_spz_entity_role_egid ON spz.spz_entity_role USING btree (entity_group_id);


--
