-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gsf
-- Object: ix_gsf_user_role_rid
-- Type: INDEX

-- Name: ix_gsf_user_role_rid; Type: INDEX; Schema: gsf; Owner: -
--

CREATE INDEX ix_gsf_user_role_rid ON gsf.gsf_user_role USING btree (role_id);


--
