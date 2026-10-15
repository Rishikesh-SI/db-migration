-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_user_mob_no_ix
-- Type: INDEX

-- Name: ss_user_mob_no_ix; Type: INDEX; Schema: eks; Owner: -
--

CREATE UNIQUE INDEX ss_user_mob_no_ix ON eks.ss_user USING btree (mobile_no, cf_clientid);


--
