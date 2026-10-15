-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: ix_rfg_user_emailid
-- Type: INDEX

-- Name: ix_rfg_user_emailid; Type: INDEX; Schema: rfg; Owner: -
--

CREATE INDEX ix_rfg_user_emailid ON rfg.rfg_user USING btree (email_id);


--
