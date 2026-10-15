-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: ix_pkl_user_emailid
-- Type: INDEX

-- Name: ix_pkl_user_emailid; Type: INDEX; Schema: labjfc; Owner: -
--

CREATE INDEX ix_pkl_user_emailid ON labjfc.labjfc_user USING btree (email_id);


--
