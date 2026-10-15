-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_user_role_uid
-- Type: INDEX

-- Name: ix_gsf_user_role_uid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_user_role_uid ON gsf.gsf_user_role USING btree (user_id);


--
