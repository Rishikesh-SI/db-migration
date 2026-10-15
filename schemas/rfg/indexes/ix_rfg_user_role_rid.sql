-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_user_role_rid
-- Type: INDEX

-- Name: ix_rfg_user_role_rid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_user_role_rid ON rfg.rfg_user_role USING btree (role_id);


--
