-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_user_emailid
-- Type: INDEX

-- Name: ix_pbl_user_emailid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_user_emailid ON pbl.pbl_user USING btree (email_id);


--
