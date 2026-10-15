-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: ix_stn_entity_role_egid
-- Type: INDEX

-- Name: ix_stn_entity_role_egid; Type: INDEX; Schema: stn; Owner: -
--

CREATE INDEX ix_stn_entity_role_egid ON stn.stn_entity_role USING btree (entity_group_id);


--
