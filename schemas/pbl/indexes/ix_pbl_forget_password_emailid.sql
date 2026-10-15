-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_forget_password_emailid
-- Type: INDEX

-- Name: ix_pbl_forget_password_emailid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_forget_password_emailid ON pbl.pbl_forget_password USING btree (email_id);


--
