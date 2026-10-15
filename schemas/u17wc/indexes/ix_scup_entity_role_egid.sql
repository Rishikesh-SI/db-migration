-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: ix_scup_entity_role_egid
-- Type: INDEX

-- Name: ix_scup_entity_role_egid; Type: INDEX; Schema: u17wc; Owner: -
--

CREATE INDEX ix_scup_entity_role_egid ON u17wc.u17wc_entity_role USING btree (entity_group_id);


--
