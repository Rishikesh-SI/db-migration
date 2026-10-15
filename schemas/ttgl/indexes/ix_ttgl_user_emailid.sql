-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttgl
-- Object: ix_ttgl_user_emailid
-- Type: INDEX

-- Name: ix_ttgl_user_emailid; Type: INDEX; Schema: ttgl; Owner: -
--

CREATE INDEX ix_ttgl_user_emailid ON ttgl.ttgl_user USING btree (email_id);


--
