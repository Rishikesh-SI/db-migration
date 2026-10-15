-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pbl
-- Object: ix_pbl_forget_password_guid
-- Type: INDEX

-- Name: ix_pbl_forget_password_guid; Type: INDEX; Schema: pbl; Owner: -
--

CREATE INDEX ix_pbl_forget_password_guid ON pbl.pbl_forget_password USING btree (reset_key_guid);


--
