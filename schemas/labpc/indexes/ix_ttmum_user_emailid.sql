-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpc
-- Object: ix_ttmum_user_emailid
-- Type: INDEX

-- Name: ix_ttmum_user_emailid; Type: INDEX; Schema: labpc; Owner: -
--

CREATE INDEX ix_ttmum_user_emailid ON labpc.labpc_user USING btree (email_id);


--
