-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_user_role_uid
-- Type: INDEX

-- Name: ix_pbl_user_role_uid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_user_role_uid ON pbl.pbl_user_role USING btree (user_id);


--
