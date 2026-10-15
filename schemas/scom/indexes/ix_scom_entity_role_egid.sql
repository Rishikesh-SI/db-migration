-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: scom
-- Object: ix_scom_entity_role_egid
-- Type: INDEX

-- Name: ix_scom_entity_role_egid; Type: INDEX; Schema: scom; Owner: -
--

CREATE INDEX ix_scom_entity_role_egid ON scom.scom_entity_role USING btree (entity_group_id);


--
