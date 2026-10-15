-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_user_emailid
-- Type: INDEX

-- Name: ix_gsf_user_emailid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_user_emailid ON gsf.gsf_user USING btree (email_id);


--
