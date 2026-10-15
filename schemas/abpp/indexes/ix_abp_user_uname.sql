-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: ix_abp_user_uname
-- Type: INDEX

-- Name: ix_abp_user_uname; Type: INDEX; Schema: abpp; Owner: -
--

CREATE UNIQUE INDEX ix_abp_user_uname ON abpp.abp_user USING btree (user_name);


--
