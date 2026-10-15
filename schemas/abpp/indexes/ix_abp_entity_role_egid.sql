-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_entity_role_egid
-- Type: INDEX

-- Name: ix_abp_entity_role_egid; Type: INDEX; Schema: abpp; Owner: -
--

CREATE INDEX ix_abp_entity_role_egid ON abpp.abp_entity_role USING btree (entity_group_id);


--
