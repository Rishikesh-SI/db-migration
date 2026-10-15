-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_user_role_rid
-- Type: INDEX

-- Name: ix_pbl_user_role_rid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_user_role_rid ON pbl.pbl_user_role USING btree (role_id);


--
